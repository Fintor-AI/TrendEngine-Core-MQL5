# TrendEngine Core – MQL5 EA Starter

A modular **trend-following EA starter** written in MQL5, designed as a clean architecture template for building professional trading systems in MetaTrader 5.

This repository is not a “magic signal EA”.  
It is an **engineering-focused skeleton** that shows how to separate:

- signal logic  
- basic risk/SL/TP handling  
- execution flow  

---

## 🔧 What You Can Build With This

- Trend-following systems (MA crossover, pullback, breakout)  
- Prototype EAs for clients and prop firms  
- Baseline systems to plug ML/filters into  
- Multi-symbol / multi-timeframe variants of the same core structure  

---

## 🧱 High-Level Architecture

The EA is split into:

- **Main EA file** (`TrendEngine_Core_Demo.mq5`)  
  - reads inputs  
  - instantiates the core engine  
  - forwards `OnTick()`  

- **Core engine class** (`TrendEngineCore.mqh`)  
  - calculates moving averages  
  - detects simple crossovers (demo logic)  
  - opens basic positions with SL/TP  

This keeps the codebase **readable, testable, and extendable**.

---

## 📂 Current Folder Structure

```text
TrendEngine-Core-MQL5/
  MQL5/
    Experts/
      TrendEngine_Core_Demo.mq5
    Include/
      TrendEngine/
        TrendEngineCore.mqh
  .gitignore
  LICENSE
  README.md
```

## 🚀 Quickstart (Conceptual)

This is a template, not a finished trading system.
Use it as a starting point for your own logic.

Copy the MQL5 directory into your MetaTrader 5 Data Folder.

Open TrendEngine_Core_Demo.mq5 in MetaEditor.

Compile the EA.

Attach it to a demo chart.

Adjust inputs (lot size, MA periods, SL/TP) as desired.

From here, you can:

plug in your own signal logic

add filters (HTF trend, volatility, session filters)

connect more advanced risk engines or management modules


##🧠 About the Author

Built and maintained by Hossein Asgari
Algorithmic Trading Architect & Founder of Fintor AI

I design trading systems the way engineers build aircraft —
modular, testable, and resilient.

LinkedIn: https://www.linkedin.com/in/hossein-asgari-3b652416a/

Website: https://fintorai.com


##⚠️ Disclaimer

This repository is for educational and engineering demonstration only.
It does not provide financial advice or guarantee profitability.
Always test thoroughly on a demo before risking real capital.
