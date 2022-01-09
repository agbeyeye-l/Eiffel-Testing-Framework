note
	description: "Summary description for {MOOC_TEST_MANAGER}."
	author: "mp"
	date: "$Date$"
	revision: "$Revision$"

class
	MOOC_TEST_MANAGER [G -> MOOC_TEST create make_with_input_output_value end]

create

	make_with_input_output_string_data

feature {NONE} -- Initialization

	make_with_input_output_string_data (input: ARRAY [STRING]; output: ARRAY [STRING]; sol_url: STRING; hidden_tests: ARRAY [BOOLEAN])
			-- Initialization for `Current' with the arrays containing input and output data, and the hidden tests.
		require
			input_same_size_as_output: input.count = output.count
			hidden_tests_same_size_as__output: hidden_tests.count = output.count
		local
			i: INTEGER
			l_test: G
		do
			create solution_url.make_from_string (sol_url)
			create tests.make (input.count)
			from
				i := 1
			until
				i > input.count
			loop
				create l_test.make_with_input_output_value (input [i], output [i])
				if hidden_tests [i] = True then
				    l_test.set_hidden
				end
				tests.extend (l_test)
				i := i + 1
			end
		ensure
			io_same_size_as_tests: input.count = tests.count
		end

feature -- Status 

	solution_url: STRING
			-- The URL corresponding to the solution.

feature -- Basic operations

	execute
			-- Execute all tests.
		local
			l_i: INTEGER
			l_all_tests_passed: BOOLEAN
			l_html_formatter: HTML_FORMATTER
			l_test_result_html_string: STRING
			l_test_results: ARRAY [STRING]
			l_passes, l_failures: INTEGER
		do
			l_all_tests_passed := True
			create l_test_results.make_filled ("False", 1, tests.count)
			-- The number of test results has to be consistent with the dimension of the tests array.
			check (l_test_results.count = tests.count) end
			create l_html_formatter
			create l_test_result_html_string.make_empty
			l_test_result_html_string.append (l_html_formatter.title_text ("<p>Testing your implementation:</p>"))
			from
				l_i := 1
			until
				l_i > tests.count
			loop
				if tests.at (l_i).is_hidden then
				    l_test_result_html_string.append ("<b>Test n. " + l_i.out + " (input value: hidden" + ")" + ":</b>")
 				else
    				l_test_result_html_string.append ("<b>Test n. " + l_i.out + " (input value: " + tests.at (l_i).input_value.out + ")" + ":</b>")
				end
				tests.at (l_i).execute
				if tests.at (l_i).has_test_passed then
					l_passes := l_passes + 1
					l_test_results.at (l_i) := "True"
				else
					l_failures := l_failures + 1
					l_test_results.at (l_i) := "False"
				end
				l_all_tests_passed := l_all_tests_passed and tests.at (l_i).has_test_passed
				l_test_result_html_string.append (tests.at (l_i).output_string)
				l_i := l_i + 1
			end
			if l_all_tests_passed then
		--		l_test_result_html_string.append (l_html_formatter.all_tests_passed ("Great! You passed all tests. <a href=%"" + solution_url + "%"> You can now have a look at our solution!</a>"))
				l_test_result_html_string.append (l_html_formatter.all_tests_passed ("Great! You passed all tests."))
			else
				l_test_result_html_string.append (l_html_formatter.all_tests_failed (l_failures.out + " test(s) fail. What about fixing the code and trying again?"))
			end
			l_test_result_html_string.append (l_html_formatter.test_information_url (test_result_as_int (l_test_results), l_passes, l_failures))
			print (l_test_result_html_string)
		end

feature {NONE} -- Implementation

	tests: ARRAYED_LIST [G]
			-- All tests to be run.

    test_result_as_int (res: ARRAY [STRING]): INTEGER
			-- Transform the array of STRINGs in which the test results are stored into an integer.
			-- Returns 1 if all tests passed, 0 otherwise.
		local
			l_i: INTEGER
			l_r: REAL_64
		do
			from
				l_i := res.count
				l_r := 1.0
			until
				l_i < 1
			loop
				if res [l_i] ~ "True" then
					l_r := l_r * 1
				else
				    l_r := l_r * 0
				end
				l_i := l_i - 1
					
			end
			Result := Result + l_r.truncated_to_integer
		end

--	test_result_as_int (res: ARRAY [STRING]): INTEGER
--			-- Transform the array of STRINGs in which the test results are stored into an integer.
--		local
--			l_i: INTEGER
--			l_r: REAL_64
--		do
--			from
--				l_i := res.count
--			until
--				l_i < 1
--			loop
--				if res [l_i] ~ "True" then
--					l_r := 2 ^ (l_i - 1)
--					Result := Result + l_r.truncated_to_integer
--				end
--				l_i := l_i - 1
--			end
--		end

end