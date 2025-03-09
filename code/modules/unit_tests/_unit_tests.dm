//include unit test files in this module in this ifdef

#if defined(UNIT_TESTS) || defined(SPACEMAN_DMM)

/// For advanced cases, fail unconditionally but don't return (so a test can return multiple results)
#define TEST_FAIL(reason) (Fail(reason || "No reason", __FILE__, __LINE__))

/// Asserts that a condition is true
/// If the condition is not true, fails the test
#define TEST_ASSERT(assertion, reason) if (!(assertion)) { return Fail("Assertion failed: [reason || "No reason"]") }

/// Asserts that the two parameters passed are equal, fails otherwise
/// Optionally allows an additional message in the case of a failure
#define TEST_ASSERT_EQUAL(a, b, message) \
	do { \
		var/lhs = ##a; \
		var/rhs = ##b; \
		if (lhs != rhs) { \
			return Fail("Expected [isnull(lhs) ? "null" : lhs] to be equal to [isnull(rhs) ? "null" : rhs].[message ? " [message]" : ""]"); \
		} \
	} while (FALSE)

/// Asserts that the two parameters passed are not equal, fails otherwise
/// Optionally allows an additional message in the case of a failure
#define TEST_ASSERT_NOTEQUAL(a, b, message) \
	do { \
		var/lhs = ##a; \
		var/rhs = ##b; \
		if (lhs == rhs) { \
			return Fail("Expected [isnull(lhs) ? "null" : lhs] to not be equal to [isnull(rhs) ? "null" : rhs].[message ? " [message]" : ""]"); \
		} \
	} while (FALSE)

#define TEST_DEFAULT 1
#define TEST_CREATE_AND_DESTROY INFINITY

//Keep this sorted alphabetically
#include "anchored_mobs.dm"
#include "component_tests.dm"
// #include "create_and_destroy.dm"
#include "reagent_id_typos.dm"
//#include "reagent_names.dm"
#include "reagent_recipe_collisions.dm"
#include "resist.dm"
#include "rogue_inhands.dm"
#include "roguetown_clothing.dm"
#include "spawn_humans.dm"
#include "spawn_mobs.dm"
#include "species_whitelists.dm"
#include "subsystem_init.dm"
#include "surgeries.dm"
#include "timer_sanity.dm"
#include "unit_test.dm"

#undef TEST_ASSERT
#undef TEST_ASSERT_EQUAL
#undef TEST_ASSERT_NOTEQUAL
#endif
