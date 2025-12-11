//+------------------------------------------------------------------+
//|  TrendEngine Core Demo – MQL5 EA                                 |
//|  Author: Hossein Asgari (Fintor AI)                              |
//+------------------------------------------------------------------+
#property strict
#property copyright "Hossein Asgari - Fintor AI"
#property link      "https://fintorai.com"
#property version   "1.00"

#include <TrendEngine/TrendEngineCore.mqh>

//--- inputs
input double InpLots     = 0.10;
input int    InpMaFast   = 20;
input int    InpMaSlow   = 50;
input int    InpSlPoints = 300;
input int    InpTpPoints = 600;

//--- core engine
CTrendEngineCore g_engine;

//+------------------------------------------------------------------+
int OnInit()
  {
   g_engine.Init(InpLots,InpMaFast,InpMaSlow,InpSlPoints,InpTpPoints);
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
   g_engine.Deinit();
  }
//+------------------------------------------------------------------+
void OnTick()
  {
   g_engine.OnTick();
  }
//+------------------------------------------------------------------+
