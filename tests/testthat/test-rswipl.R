test_that("queries can be formed", 
{
  q <- query(call("member", expression(X), list(quote(a), "b", 3L, 4, TRUE, expression(Y), NA, NaN, Inf, NULL)))
  submit()
  clear()
  expect_true(q)
})

test_that("atoms are properly translated",
{
  query(call("member", expression(X), list(quote(a), "b", 3L, 4, TRUE, expression(Y), NA, NaN, Inf, NULL)))
  q <- submit()
  clear()

  expect_equal(q$X, quote(a))
})

test_that("strings are properly translated",
{
  query(call("member", expression(X), list(quote(a), "b", 3L, 4, TRUE, expression(Y), NA, NaN, Inf, NULL)))
  submit()
  q <- submit()
  clear()

  expect_equal(q$X, "b")
})

test_that("integers are properly translated",
{
  query(call("member", expression(X), list(quote(a), "b", 3L, 4, TRUE, expression(Y), NA, NaN, Inf, NULL)))
  submit()
  submit()
  q <- submit()
  clear()

  expect_equal(q$X, 3L)
})

test_that("floating point numbers are properly translated",
{
  query(call("member", expression(X), list(quote(a), "b", 3L, 4, TRUE, expression(Y), NA, NaN, Inf, NULL)))
  submit()
  submit()
  submit()
  q <- submit()
  clear()

  expect_equal(q$X, 4)
})

test_that("booleans are properly translated",
{
  query(call("member", expression(X), list(quote(a), "b", 3L, 4, TRUE, expression(Y), NA, NaN, Inf, NULL)))
  submit()
  submit()
  submit()
  submit()
  q <- submit()
  clear()

  expect_true(q$X)
})

test_that("variables are properly translated",
{
  query(call("member", expression(X), list(quote(a), "b", 3L, 4, TRUE, expression(Y), NA, NaN, Inf, NULL)))
  submit()
  submit()
  submit()
  submit()
  submit()
  q <- submit()
  clear()

  if(!is.null(q$X))
    return(expect_identical(q$X, expression(Y)))
  if(!is.null(q$Y))
    return(expect_identical(q$Y, expression(X)))

  fail()
})

test_that("missing values are properly translated",
{
  query(call("member", expression(X), list(quote(a), "b", 3L, 4, TRUE, expression(Y), NA, NaN, Inf, NULL)))
  submit()
  submit()
  submit()
  submit()
  submit()
  submit()
  q <- submit()
  clear()

  expect_true(is.na(q$X))
})

test_that("nans are properly translated",
{
  query(call("member", expression(X), list(quote(a), "b", 3L, 4, TRUE, expression(Y), NA, NaN, Inf, NULL)))
  submit()
  submit()
  submit()
  submit()
  submit()
  submit()
  submit()
  q <- submit()
  clear()

  expect_true(is.nan(q$X))
})

test_that("Inf is properly translated",
{
  query(call("member", expression(X), list(quote(a), "b", 3L, 4, TRUE, expression(Y), NA, NaN, Inf, NULL)))
  submit()
  submit()
  submit()
  submit()
  submit()
  submit()
  submit()
  submit()
  q <- submit()
  clear()

  expect_equal(q$X, Inf)
})

test_that("NULL is properly translated",
{
  query(call("member", expression(X), list(quote(a), "b", 3L, 4, TRUE, expression(Y), NA, NaN, Inf, NULL)))
  submit()
  submit()
  submit()
  submit()
  submit()
  submit()
  submit()
  submit()
  submit()
  q <- submit()
  clear()

  expect_null(q$X)
})

test_that("formals are properly translated",
{
  f <- function(x) {y <- sin(x); y^2}

  query(call("member", expression(X), list(quote(a), "b", 3L, 4, TRUE, expression(Y), NA, NaN, Inf, NULL, f)))
  submit()
  submit()
  submit()
  submit()
  submit()
  submit()
  submit()
  submit()
  submit()
  submit()
  q <- submit()
  clear()

  expect_identical(formals(q$X), formals(f))
})

test_that("function bodies are properly translated",
{
  f <- function(x) {y <- sin(x); y^2}
  bf <- body(f)

  query(call("member", expression(X), list(quote(a), "b", 3L, 4, TRUE, expression(Y), NA, NaN, Inf, NULL, f)))
  submit()
  submit()
  submit()
  submit()
  submit()
  submit()
  submit()
  submit()
  submit()
  submit()
  q <- submit()
  clear()

  bq <- body(q$X)
  expect_identical(sapply(FUN=as.character, bf), sapply(FUN=as.character, bq))
})

test_that("matrices are properly translated",
{
  m <- matrix(1:6, nrow=2)

  query(call("member", expression(X), list(quote(a), "b", 3L, 4, TRUE, expression(Y), NA, NaN, Inf, NULL, m)))
  submit()
  submit()
  submit()
  submit()
  submit()
  submit()
  submit()
  submit()
  submit()
  submit()
  q <- submit()
  clear()

  expect_identical(q$X, m)
})

# For the future (currently memory leaking)
#
# test_that("check_installation works",
# {
#   query(call("check_installation"))
#   q <- submit()
#   clear()
# 
#   # A few warnings will be displayed, that is fine.
#   expect_equal(q, list())
# })
#
# test_that("test_installation works",
# {
#   query(call("test_installation", 
#     list(call(arguments(list("-e", "rswipl:::swipl()", "-q", "--no-echo", "--args"))))
#   q <- submit()
#   clear()
#
#   expect_equal(q, list())
# })
