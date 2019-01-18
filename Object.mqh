//+------------------------------------------------------------------+
//|                 EA31337 - multi-strategy advanced trading robot. |
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

// Properties.
#property strict

// Prevents processing this includes file for the second time.
#ifndef OBJECT_MQH
#define OBJECT_MQH

/**
 * Class to deal with objects.
 */
class Object {
  public:
    static Object *list[];
    void *obj;

    /**
     * Class constructor.
     */
    void Object() {
      /* @fixme
      uint _size = ArraySize(list);
      ArrayResize(list, _size + 1, 100);
      list[_size] = GetPointer(this);
      */
    }
    void Object(void *_obj) {
      this.obj = _obj;
    }

    /* Virtual methods */

    /**
     * Weight of the object.
     */
    virtual double Weight() = NULL;

    /**
     * Check whether pointer is valid.
     */
    static bool Valid(void *_obj) {
      return CheckPointer(_obj) != POINTER_INVALID;
    }
    bool Valid() {
      return Valid(this.obj);
    }

    /**
     * Returns text representation of the object.
     */
    virtual string ToString() {
      return StringFormat("[Object #%04x]", GetPointer(this));
    }

    /**
     * Safely delete the object.
     */
    static void Delete(void *_obj) {
      if (CheckPointer(_obj) == POINTER_DYNAMIC) {
        delete _obj;
      }
    }
    void Delete() {
      Delete(this.obj);
    }

};

// Initialize static global variables.
//Object *Object::list = { 0 };
#endif // OBJECT_MQH
