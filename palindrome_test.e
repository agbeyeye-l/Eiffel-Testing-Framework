note
	description: "Implementation test class containing test-specific code. HowTo: implement deferred feature execute_test_oracle in your specific case (see example below)."
	author: "mp"
	date: "$Date$"
	revision: "$Revision$"

class
	PALINDROME_TEST

inherit
	MOOC_TEST

create
	make_with_input_output_value

feature -- Basic operations

	execute_test_oracle
			-- Execute the test oracle.
		local
			l_word_games: WORD_GAMES
			l_test_result: BOOLEAN
		--	ex: EXCEPTIONS
		do
			--To raise a test exception use set_exception (True)
		--	if is_exception_raised then
		--		create ex
		--		ex.raise ("Test exception")
		--	end
			create l_word_games
			l_test_result := l_word_games.is_palindrome (input_value)

			if l_test_result = output_value.to_boolean then
				has_test_passed := True
				test_result_value := l_test_result.out
			else
				has_test_passed := False
				test_result_value := l_test_result.out
			end
		end
end