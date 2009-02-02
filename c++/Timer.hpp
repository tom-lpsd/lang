#ifndef _TIMER_HPP
#define _TIMER_HPP
#include <ctime>
#include <memory>
#include <iostream>

namespace utility
{

    /** @brief mesures elapsed time. */
    class Timer {
    public:

	class Callback {
	public:
	    virtual void operator() (Timer &) = 0;
	    virtual ~Callback() {}
	};

	class PrintMessage : public Callback {
	public:
	    explicit PrintMessage(const char *msg) : message_(msg) {}
	    void operator() (Timer &timer) {
		std::cerr << message_ << ": " 
			  << timer.elapsedTime() << "[msec]" << std::endl;
	    }
	private:
	    const char *message_;
	};

	explicit
	Timer() : callback_(0), start_(std::clock()) {}

	explicit
	Timer(const char *msg) : callback_(new PrintMessage(msg)), start_(std::clock()) {}

	Timer(Callback *f) : callback_(f), start_(std::clock()) {}

	/** @brief return elapsed time (msec) */
	double elapsedTime() {
	    return (std::clock()-start_)*1000.0/CLOCKS_PER_SEC;
	}

	/** @brief reset this timer.  */
	void reset() { start_ = std::clock(); }

	/** @brief execute callback */
	~Timer() { (*callback_)(*this); }

    private:
	std::auto_ptr<Callback> callback_;
	std::clock_t start_;
    };

} // end of namespace

#endif // _TIMER_HPP
