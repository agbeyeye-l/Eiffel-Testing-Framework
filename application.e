note
	description : "[
					Root class for MOOC testing. What to do to create a new test suite:
					1. Create a specific class for the type you want to test (e.g. PALINDROME_TEST). It has to extend MOOC_TEST.
					2. In the class chosen at 1., implement feature execute_test_oracle (see example in PALINDROME_TEST).
					3. In class APPLICATION.make, insert the actual generic parameter value for local variable l_test_manager using the type chosen at 1.
					4. Insert the appropriate URL string pointing at the solution folder as third argument to feature l_test_manager.make_with_input_output_string_data  
					5. Initialize arrays input_data and output_data properly with the desired values.
					]"
	author		: "mp"
	date        : "$Date$"
	revision    : "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			l_test_manager: MOOC_TEST_MANAGER [PALINDROME_TEST]
		do
			create l_test_manager.make_with_input_output_string_data (input_data, output_data, "http://bmse-sandbox.inf.ethz.ch:8080/e4mooc/#solution_test_102", hidden_tests)
			l_test_manager.execute
		end

feature {NONE} -- Implementation

			input_data: ARRAY [STRING]
					-- Input data for testing.
				once
					Result := <<"ANNA", "madam", "rotor", "kayak", "reviver", "racecar", "redder", "malayalam", "Roma", "pollo", "able was i ere i saw elba">>
				end

			output_data: ARRAY [STRING]
					-- Output data for testing.
				once
					Result := <<"True", "True", "True", "True", "True", "True", "True", "True", "False", "False", "True">>
				end
            
            hidden_tests: ARRAY [BOOLEAN] 
                    -- Hidden tests.
                once
                    Result := <<False, False, False, False, False, False, False, False, False, True, True>>
                end
invariant
		input_data_size_consistent_with_output_data_size: input_data.count = output_data.count
		hidden_tests_size_consistent_with_output_data_size: hidden_tests.count = output_data.count
end