//+------------------------------------------------------------------+
//|                                                EA31337 framework |
//|                       Copyright 2016-2019, 31337 Investments Ltd |
//|                                       https://github.com/EA31337 |
//+------------------------------------------------------------------+

/*
 * This file is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 */

// Includes.
#include "../Indicator.mqh"

// Structs.
struct Force_Params {
  uint               period;
  ENUM_MA_METHOD     ma_method;
  ENUM_APPLIED_PRICE applied_price;
  // Constructor.
  void Force_Params(uint _period, ENUM_MA_METHOD _ma_method, ENUM_APPLIED_PRICE _ap)
    : period(_period), ma_method(_ma_method), applied_price(_ap) {};
};

/**
 * Implements the Force Index indicator.
 */
class Indi_Force : public Indicator {

public:

    Force_Params params;

    /**
     * Class constructor.
     */
    Indi_Force(Force_Params &_params, IndicatorParams &_iparams, ChartParams &_cparams)
      : params(_params.period, _params.ma_method, _params.applied_price), Indicator(_iparams, _cparams) {};

    /**
     * Returns the indicator value.
     *
     * @docs
     * - https://docs.mql4.com/indicators/iforce
     * - https://www.mql5.com/en/docs/indicators/iforce
     */
    static double iForce(
        string _symbol,
        ENUM_TIMEFRAMES _tf,
        uint _period,
        ENUM_MA_METHOD _ma_method,         // (MT4/MT5): MODE_SMA, MODE_EMA, MODE_SMMA, MODE_LWMA
        ENUM_APPLIED_PRICE _applied_price, // (MT4/MT5): PRICE_CLOSE, PRICE_OPEN, PRICE_HIGH, PRICE_LOW, PRICE_MEDIAN, PRICE_TYPICAL, PRICE_WEIGHTED
        int _shift = 0
        ) {
      #ifdef __MQL4__
      return ::iForce(_symbol, _tf, _period, _ma_method, _applied_price, _shift);
      #else // __MQL5__
      double _res[];
      int _handle = ::iForce(_symbol, _tf, _period, _ma_method, VOLUME_TICK);
      return CopyBuffer(_handle, 0, _shift, 1, _res) > 0 ? _res[0] : EMPTY_VALUE;
      #endif
    }
    double GetValue(uint _shift = 0) {
      double _value = iForce(GetSymbol(), GetTf(), GetPeriod(), GetMAMethod(), GetAppliedPrice(), _shift);
      CheckLastError();
      return _value;
    }

    /* Getters */

    /**
     * Get period value.
     */
    uint GetPeriod() {
      return this.params.period;
    }

    /**
     * Get MA method.
     */
    ENUM_MA_METHOD GetMAMethod() {
      return this.params.ma_method;
    }

    /**
     * Get applied price value.
     */
    ENUM_APPLIED_PRICE GetAppliedPrice() {
      return this.params.applied_price;
    }

    /* Setters */

    /**
     * Set period value.
     */
    void SetPeriod(uint _period) {
      this.params.period = _period;
    }

    /**
     * Set MA method.
     */
    void SetMAMethod(ENUM_MA_METHOD _ma_method) {
      this.params.ma_method = _ma_method;
    }

    /**
     * Set applied price value.
     */
    void SetAppliedPrice(ENUM_APPLIED_PRICE _applied_price) {
      this.params.applied_price = _applied_price;
    }

};
