# Monorails

[![Build Status](https://travis-ci.org/byroot/monorails.svg)](http://travis-ci.org/byroot/monorails)
[![Gem Version](https://badge.fury.io/rb/monorails.png)](http://badge.fury.io/rb/byroot/monorails)

Monkey patch Rails to make it faster in non thread safe applications

**CAUTION: Use this gem at your own risk.**

If your application is not doing any threading, then `monorails` can bring you a few performance
improvements at the cost of losing thread safety.

## Explanation

First `monorails` includes `thread_hazardous` that bring a substential performance improvement.
[See it's readme for explanation](https://github.com/byroot/thread_hazardous#explanation).

`monorails` also patches `ActiveSupport::PerThreadRegistry` that is used in a couple Rails hotspots.
`PerThreadRegistry` stores an instance in `Thread.current` which is way slower than a regular instance variable:

```
Calculating -------------------------------------
         thread-safe    25.176k i/100ms
       thread-unsafe    30.069k i/100ms
-------------------------------------------------
         thread-safe      1.480M (± 6.5%) i/s -      7.377M
       thread-unsafe      2.480M (± 7.2%) i/s -     12.328M
```
For full details see [the benchmark implementation](https://gist.github.com/byroot/919e7756be7f89ec19af)

`monorails` also backport [a performance patch from Rails 4.2](https://github.com/rails/rails/commit/28d52c59f2cb32180ca24770bf95597ea3ad8198) for older versions.

These operations themselves are not that costly, but they are often used in heavy hotspots, especially in Rails, so in the end it adds up.
Here's a profiling real life application under real life load:

```
==================================
  Mode: wall(1000)
  Samples: 15836 (0.35% miss rate)
  GC: 696 (4.40%)
==================================
TOTAL (pct)   SAMPLES (pct)   FRAME
429   (2.5%)    429   (2.5%)  ActiveSupport::PerThreadRegistry#per_thread_registry_instance
419   (2.6%)    419   (2.6%)  ThreadSafe::NonConcurrentCacheBackend#[]
208   (1.3%)    208   (1.3%)  ThreadSafe::NonConcurrentCacheBackend#dupped_backend
 75   (0.5%)     75   (0.5%)  block in ThreadSafe::Cache#values
151   (0.9%)    147   (0.9%)  block in ActiveRecord::AttributeMethods::ClassMethods#define_attribute_methods
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'monorails'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install monorails

## Usage

Nothing more to do, it's all automatic.

## Contributing

1. Fork it ( https://github.com/byroot/monorails/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
