//
//  tbb_test.cpp
//  TBB-Test
//
//  Created by Taylor Holliday on 11/11/23.
//

#include <stdio.h>
#include "tbb/tbb_allocator.h"
#include "tbb/parallel_reduce.h"
#include "tbb/blocked_range.h"

void test() {
    int sum = oneapi::tbb::parallel_reduce(oneapi::tbb::blocked_range<int>(1,101), 0,
       [](oneapi::tbb::blocked_range<int> const& r, int init) -> int {
          for (int v = r.begin(); v != r.end(); v++  ) {
             init += v;
          }
          return init;
       },
       [](int lhs, int rhs) -> int {
          return lhs + rhs;
       }
    );
}
