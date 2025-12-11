//+------------------------------------------------------------------+
//|  TrendEngine Core – demo architecture (no guarantee of profit)   |
//+------------------------------------------------------------------+
#pragma once

class CTrendEngineCore
  {
private:
   double m_lots;
   int    m_ma_fast;
   int    m_ma_slow;
   int    m_sl_points;
   int    m_tp_points;

   int    m_fast_handle;
   int    m_slow_handle;

public:
                     CTrendEngineCore()
     {
      m_lots      = 0.10;
      m_ma_fast   = 20;
      m_ma_slow   = 50;
      m_sl_points = 300;
      m_tp_points = 600;

      m_fast_handle = INVALID_HANDLE;
      m_slow_handle = INVALID_HANDLE;
     }

   //--- init / deinit
   void              Init(double lots,
                          int    ma_fast,
                          int    ma_slow,
                          int    sl_points,
                          int    tp_points)
     {
      m_lots      = lots;
      m_ma_fast   = ma_fast;
      m_ma_slow   = ma_slow;
      m_sl_points = sl_points;
      m_tp_points = tp_points;

      m_fast_handle = iMA(_Symbol,_Period,m_ma_fast,0,MODE_EMA,PRICE_CLOSE);
      m_slow_handle = iMA(_Symbol,_Period,m_ma_slow,0,MODE_EMA,PRICE_CLOSE);

      if(m_fast_handle == INVALID_HANDLE || m_slow_handle == INVALID_HANDLE)
         Print(__FUNCTION__,": failed to create MA handles. Error: ",GetLastError());
     }

   void              Deinit()
     {
      if(m_fast_handle != INVALID_HANDLE)
         IndicatorRelease(m_fast_handle);
      if(m_slow_handle != INVALID_HANDLE)
         IndicatorRelease(m_slow_handle);
     }

   //--- main loop
   void              OnTick()
     {
      if(m_fast_handle == INVALID_HANDLE || m_slow_handle == INVALID_HANDLE)
         return;

      // only signal on closed bars
      if(Bars(_Symbol,_Period) < m_ma_slow + 2)
         return;

      double fast[3], slow[3];
      if(CopyBuffer(m_fast_handle,0,1,3,fast) != 3) return;
      if(CopyBuffer(m_slow_handle,0,1,3,slow) != 3) return;

      // simple MA crossover
      bool buy_signal  = (fast[1] > slow[1] && fast[2] <= slow[2]);
      bool sell_signal = (fast[1] < slow[1] && fast[2] >= slow[2]);

      // ignore if any position is already open (simple demo behaviour)
      if(PositionsTotal() > 0)
         return;

      if(buy_signal)
         OpenPosition(ORDER_TYPE_BUY);
      else if(sell_signal)
         OpenPosition(ORDER_TYPE_SELL);
     }

private:

   void              OpenPosition(ENUM_ORDER_TYPE type)
     {
      double price = (type == ORDER_TYPE_BUY)
                     ? SymbolInfoDouble(_Symbol,SYMBOL_ASK)
                     : SymbolInfoDouble(_Symbol,SYMBOL_BID);

      double sl = 0.0;
      double tp = 0.0;

      if(type == ORDER_TYPE_BUY)
        {
         sl = price - m_sl_points * _Point;
         tp = price + m_tp_points * _Point;
        }
      else
        {
         sl = price + m_sl_points * _Point;
         tp = price - m_tp_points * _Point;
        }

      MqlTradeRequest  req;
      MqlTradeResult   res;
      ZeroMemory(req);
      ZeroMemory(res);

      req.action    = TRADE_ACTION_DEAL;
      req.symbol    = _Symbol;
      req.volume    = m_lots;
      req.type      = type;
      req.price     = price;
      req.sl        = sl;
      req.tp        = tp;
      req.deviation = 20;
      req.magic     = 20251212;
      req.comment   = "TrendEngineCore demo";

      if(!OrderSend(req,res))
         Print(__FUNCTION__,": OrderSend failed. Error: ",GetLastError());
     }
  };
