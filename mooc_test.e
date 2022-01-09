note
	description: "Summary description for {MOOC_TEST}."
	author: "mp"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	MOOC_TEST

feature {MOOC_TEST} -- Creation

	make_with_input_output_value (in_val, out_val: STRING)
			-- Initialization for `Current' with input value `in' and output value `out'.
		do
			create output_string.make_empty
			create test_result_value.make_empty
			input_value := in_val
			output_value := out_val
			create test_formatter
		ensure
			input_value_set: input_value = in_val
			output_value_set: output_value = out_val
		end

feature -- Access

	input_value: STRING
			-- Test provided input value.

	output_value: STRING
			-- Test expected output value.		

	test_result_value: STRING
			-- Test produced result value.

	has_test_passed: BOOLEAN
			-- Has test been successful?

	is_exception_raised: BOOLEAN
			-- Has an exception been raised during this test execution?

	test_formatter: HTML_FORMATTER
			-- Html output formatter for Current.

	output_string: STRING
			-- Test result as output string in HTML format.
	
	is_hidden: BOOLEAN
	        -- Is this test hidden?

feature {MOOC_TEST_MANAGER} -- Status setting

	set_exception (f: BOOLEAN)
			-- Emulate an exception for Current.
		do
			is_exception_raised := f
		end

	set_hidden
			-- Make a test hidden.
		do
			is_hidden := True
		end

feature -- Basic operations

	frozen execute
			-- Execute test, handle exceptions and delegate test oracle execution.
		local
			e: EXCEPTIONS
			e_flag: BOOLEAN
		do
			create e
			if e_flag then
				if attached {STRING}e.exception_trace as s then
					output_string.append (test_formatter.format_generic_exception ("The system detected a runtime exception. This may be due to a contract violation in your code."))
					output_string.append (test_formatter.format_generic_exception (s))
				end
			else
				execute_test_oracle
				if has_test_passed then
					output_string.append (test_formatter.single_test_passed ("passed with value " + output_value))
				else
					output_string.append (test_formatter.single_test_failed ("failed. Correct value was: " + output_value + ". Incorrect value produced by your implementation: " + test_result_value))
				end
			end
		rescue
			e_flag := True
			retry
		end

	execute_test_oracle
			-- Execute the test oracle.
		deferred

		end
end