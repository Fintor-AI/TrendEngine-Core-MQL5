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
