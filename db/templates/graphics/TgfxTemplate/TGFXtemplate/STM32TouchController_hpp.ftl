
#ifndef STM32TOUCHCONTROLLER_HPP
#define STM32TOUCHCONTROLLER_HPP

#include <platform/driver/touch/TouchController.hpp>

class STM32TouchController : public touchgfx::TouchController
{
public:
    STM32TouchController() {}
    virtual ~STM32TouchController() {}
    virtual void init();
    virtual bool sampleTouch(int32_t& x, int32_t& y);
};

#endif // STM32TOUCHCONTROLLER_HPP
