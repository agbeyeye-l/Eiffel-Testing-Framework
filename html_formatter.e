note
    description: "Helper class to format HTML output for the MOOC testing framework."
	author: "am"
	date: "$Date$"
	revision: "$Revision$"

class
	HTML_FORMATTER

feature -- Printing HTML formatted feedback

	single_test_passed (text: STRING): STRING
			-- HTML displaying information about a single passed test.
		do
			Result := "<div><table style=%"width:100%%; line-height: 10px%"><tr style=%"background-color: #80e680%"><td style=%"padding: 1px; padding-right:10px%"></td><td style=%"width: 100%%%">" + text + "</td></tr></table></div>"
		end

	single_test_failed (text: STRING): STRING
			-- HTML displaying information about a single failed test.
		do
        	Result := "<div><table style=%"width:100%%; line-height: 10px%"><tr style=%"background-color: #ffcccc%"><td style=%"padding: 1px; padding-right:10px%"></td><td style=%"width: 100%%%">" + text + "</td></tr></table></div>"
		end

	all_tests_passed (text: STRING): STRING
			-- HTML displaying information about all tests passed.
		do
    		Result := "<div><table style=%"width:100%%; line-height: 10px%"><tr style=%"background-color: #7DE3D2%"><td style=%"padding: 1px; padding-right:10px%"></td><td style=%"width: 100%%%">" + text + "</td></tr></table></div>"
		end

	all_tests_failed (text: STRING): STRING
			-- HTML displaying information about all tests failed.
		do
            Result := "<div><table style=%"width:100%%; line-height: 10px%"><tr style=%"background-color: #FA96A0%"><td style=%"padding: 1px; padding-right:10px%"></td><td style=%"width: 100%%%">" + text + "</td></tr></table></div>"
		end

	test_information_url (test_result, num_test_passed, num_test_failed: INTEGER): STRING
	        -- Test information URL.
		do
    		Result := "<!--@test=" + test_result.out + ";" + num_test_passed.out + ";" + num_test_failed.out + ";" + "-->"
		end


	title_text (text: STRING): STRING
			-- HTML displaying the title of the test summary information for students.
		do
    		Result := "<table style=%"width:100%%; line-height: 10px%"><thead> <tr style=%"background-color:#7DE3D2%"> <th>" + text + "</th></tr> </thead></table>"
		end

	format_generic_exception (text: STRING): STRING
			-- HTML for formatting information about a possible exception encountered.
		do
            Result := "<pre><div><table style=%"width:100%%; line-height: 10px%"><tr style=%"background-color: #FA96A0%"><td style=%"padding: 1px; padding-right:10px%"></td><td style=%"width: 100%%%">" + text + "</td></tr></table></div></pre>"
		end
end