test_that("rswipl can be loaded and unloaded", 
{
  expect_true(rswipl_init() & rswipl_done())
})
