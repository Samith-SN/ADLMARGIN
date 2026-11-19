function add_suppliers_customers_details() {
               var m_new_total_count = parseInt(document.Form1.hid_suppliers_customers_details_count.value) + 1;
               if (parseInt(document.Form1.hid_suppliers_customers_details_count.value) == 0) {
                   document.getElementById("DIV_SUPPLIERS_CUSTOMERS_DETAILS").innerHTML = '';
               }
               createDIV('DIV_SUPPLIERS_CUSTOMERS_DETAILS', m_new_total_count);
               if (parseInt(document.Form1.hid_suppliers_customers_details_count.value) == 0) {
                   document.getElementById("DIV_SUPPLIERS_CUSTOMERS_DETAILS" + m_new_total_count).innerHTML = '' + 
                       '   <table> ' + 
                       '       <tr> ' + 
                       '           <td class = "div_input" align = "center" style = "width: 50px;"></td> ' + 
                       '           <td class = "div_input" align = "center" style = "width: 50px;"></td> ' + 
                       '           <td class = "div_input" align = "center" style = "width: 125px;"><b>Supplier Type</b></td> ' + 
                       '           <td class = "div_input" align = "center" style = "width: 250px;"><div id = "DIV_TXT_S10_COMPANY_NAME_' + m_new_total_count + '"><b>Company Name</b></div></td> ' + 
                       '       </tr> ' + 
                       '       <tr> ' + 
                       '           <td><input class = "but_input" type = "button" name = "BUT_ADD_SUPPLIERS_CUSTOMERS_DETAILS" value = "+" onClick = "add_suppliers_customers_details();" /></td> ' + 
                       '           <td><input class = "but_input" type = "button" name = "BUT_DELETE_SUPPLIERS_CUSTOMERS_DETAILS" value = "-" onClick = "delete_suppliers_customers_details(' + m_new_total_count + ');" /></td> ' + 
                       '           <td><select class = "txt_input" name="TXT_S10_CUSTOMER_TYPE_' + m_new_total_count + '" style = "width: 125px;" onChange = "hideCompanyNameLabel(' + m_new_total_count + ')" /><option value = "C">Corporate</option><option value = "I">Individual</option></select></td> ' + 
                       '           <td><input class = "txt_input" type = "text" name = "TXT_S10_COMPANY_NAME_' + m_new_total_count + '" maxlength = "100" style = "width: 250px;" onBlur = "strTrim(this, null, null, \'NAME\'); strProperCase(this);" /></td> ' + 
                       '       </tr> ' + 
                       '   </table> ' + 
                       '   <table> ' + 
                       '       <tr> ' + 
                       '           <td style = "width: 50px;"></td> ' + 
                       '           <td style = "width: 50px;"></td> ' + 
                       '           <td class = "div_input" align = "center" style = "width: 175px;"><b>Type</b></td> ' + 
                       '           <td class = "div_input" align = "center" style = "width: 75px;"><b>Title</b></td> ' + 
                       '           <td class = "div_input" align = "center" style = "width: 125px;"><b>Last Name</b></td> ' + 
                       '           <td class = "div_input" align = "center" style = "width: 75px;"><b>Initials</b></td> ' + 
                       '           <td class = "div_input" align = "center" style = "width: 250px;"><b>Name Denoted by Initials</b></td> ' + 
                       '       </tr> ' + 
                       '       <tr> ' + 
                       '           <td style = "width: 50px;"></td> ' + 
                       '           <td style = "width: 50px;"></td> ' + 
                       '           <td><select class = "txt_input" name="TXT_S10_TYPE_' + m_new_total_count + '" style = "width: 175px;" /> ' + m_types_supplier_or_customer + ' </select></td> ' + 
                       '           <td><select class = "txt_input" name="TXT_S10_TITLE_' + m_new_total_count + '" style = "width: 75px;" /> ' + m_types_title + ' </select></td> ' + 
                       '           <td><input class = "txt_input" type = "text" name = "TXT_S10_LAST_NAME_' + m_new_total_count + '" maxlength = "100" style = "width: 125px;" onBlur = "strTrim(this, null, null, \'NAME\'); strProperCase(this);" /></td> ' + 
                       '           <td><input class = "txt_input" type = "text" name = "TXT_S10_INITIALS_' + m_new_total_count + '" maxlength = "30" style = "width: 75px;" onBlur = "strTrim(this);" /></td> ' + 
                       '           <td><input class = "txt_input" type = "text" name = "TXT_S10_INITIALS_DETAILS_' + m_new_total_count + '" maxlength = "400" style = "width: 250px;" onBlur = "strTrim(this, null, null, \'NAME\'); strProperCase(this); setInitials(this, document.Form1.elements[\'TXT_S10_INITIALS_' + m_new_total_count + '\']);" /></td> ' + 
                       '       </tr> ' + 
                       '   </table> ' + 
                       '   <table> ' + 
                       '       <tr> ' + 
                       '           <td style = "width: 50px;"></td> ' + 
                       '           <td style = "width: 50px;"></td> ' + 
                       '           <td class = "div_input" align = "center" style = "width: 125px;"><b>Address Type</b></td> ' + 
                       '           <td class = "div_input" align = "center" style = "width: 125px;"><b>Ownership</b></td> ' + 
                       '           <td class = "div_input" align = "center" style = "width: 250px;"><b>Address Line 1</b></td> ' + 
                       '           <td class = "div_input" align = "center" style = "width: 250px;"><b>Address Line 2</b></td> ' + 
                       '       </tr> ' + 
                       '       <tr> ' + 
                       '           <td style = "width: 50px;"></td> ' + 
                       '           <td style = "width: 50px;"></td> ' + 
                       '           <td><select class = "txt_input" name="TXT_S10_ADDRESS_TYPE_' + m_new_total_count + '" style = "width: 125px;" /> ' + m_types_address + ' </select></td> ' + 
                       '           <td><select class = "txt_input" name="TXT_S10_OWNERSHIP_' + m_new_total_count + '" style = "width: 125px;" /> ' + m_types_ownership + ' </select></td> ' + 
                       '           <td><input class = "txt_input" type = "text" name = "TXT_S10_ADDRESS_LINE_1_' + m_new_total_count + '" maxlength = "100" style = "width: 250px;" onBlur = "strTrim(this, null, null, \'ADDRESS\'); strProperCase(this);" /></td> ' + 
                       '           <td><input class = "txt_input" type = "text" name = "TXT_S10_ADDRESS_LINE_2_' + m_new_total_count + '" maxlength = "100" style = "width: 250px;" onBlur = "strTrim(this, null, null, \'ADDRESS\'); strProperCase(this);" /></td> ' + 
                       '       </tr> ' + 
                       '   </table> ' + 
                       '   <table> ' + 
                       '       <tr> ' + 
                       '           <td style = "width: 50px;"></td> ' + 
                       '           <td style = "width: 50px;"></td> ' + 
                       '           <td class = "div_input" align = "center" style = "width: 175px;"><b>City</b></td> ' + 
                       '           <td class = "div_input" align = "center" style = "width: 125px;"><b>District</b></td> ' + 
                       '           <td class = "div_input" align = "center" style = "width: 125px;"><b>Province</b></td> ' + 
                       '           <td class = "div_input" align = "center" style = "width: 125px;"><b>Country</b></td> ' + 
                       '       </tr> ' + 
                       '       <tr> ' + 
                       '           <td style = "width: 50px;"></td> ' + 
                       '           <td style = "width: 50px;"></td> ' + 
                       '           <td> ' + 
                       '               <input type = "hidden" name = "TXT_S10_CITY_' + m_new_total_count + '" /> ' + 
                       '               <input class = "txt_input" type = "text" name = "TXT_S10_CITY_NAME_' + m_new_total_count + '" maxlength = "50" onBlur = "strTrim(this); help_update_s10_city(\'help_update_s10_city_' + m_new_total_count + '\', ' + '\'' + m_new_total_count + '\');" style = "width: 125px;" /> ' + 
                       '               <input class = "but_input" type = "button" name = "BUT_HELP_S10_CITY" value = "..." onClick = "help_update_s10_city(\'help_update_s10_city_' + m_new_total_count + '\', ' + '\'' + m_new_total_count + '\');" /><a id = "help_update_s10_city_' + m_new_total_count + '" style = "{text-decoration: none; cursor: text;}" class = "fancylink iframe" href = "" > </a> ' + 
                       '           </td> ' + 
                       '           <td><input class = "txt_input" type = "text" name = "TXT_S10_DISTRICT_NAME_' + m_new_total_count + '" disabled = "disabled" style = "width: 125px;" /></td> ' + 
                       '           <td><input class = "txt_input" type = "text" name = "TXT_S10_PROVINCE_NAME_' + m_new_total_count + '" disabled = "disabled" style = "width: 125px;" /></td> ' + 
                       '           <td><input class = "txt_input" type = "text" name = "TXT_S10_COUNTRY_NAME_' + m_new_total_count + '" disabled = "disabled" style = "width: 125px;" /></td> ' + 
                       '       </tr> ' + 
                       '   </table> ' + 
                       '   <table> ' + 
                       '       <tr> ' + 
                       '           <td style = "width: 50px;"></td> ' + 
                       '           <td style = "width: 50px;"></td> ' + 
                       '           <td class = "div_input" align = "center" style = "width: 125px;"><b>Telephone 1</b></td> ' + 
                       '           <td class = "div_input" align = "center" style = "width: 125px;"><b>Telephone 2</b></td> ' + 
                       '           <td class = "div_input" align = "center" style = "width: 125px;"><b>Mobile</b></td> ' + 
                       '           <td class = "div_input" align = "center" style = "width: 125px;"><b>Fax</b></td> ' + 
                       '           <td class = "div_input" align = "center" style = "width: 175px;"><b>Email</b></td> ' + 
                       '       </tr> ' + 
                       '       <tr> ' + 
                       '           <td style = "width: 50px;"></td> ' + 
                       '           <td style = "width: 50px;"></td> ' + 
                       '           <td><input class = "txt_input" type = "text" name = "TXT_S10_TELEPHONE_1_' + m_new_total_count + '" maxlength = "14" value= "0094" style = "width: 125px;" onBlur = "validatePhoneNumber(this, \'Telephone\');" /></td> ' + 
                       '           <td><input class = "txt_input" type = "text" name = "TXT_S10_TELEPHONE_2_' + m_new_total_count + '" maxlength = "14" value= "0094" style = "width: 125px;" onBlur = "validatePhoneNumber(this, \'Telephone\');" /></td> ' + 
                       '           <td><input class = "txt_input" type = "text" name = "TXT_S10_MOBILE_' + m_new_total_count + '" maxlength = "14" value= "0094" style = "width: 125px;" onBlur = "validatePhoneNumber(this, \'Mobile\');" /></td> ' + 
                       '           <td><input class = "txt_input" type = "text" name = "TXT_S10_FAX_' + m_new_total_count + '" maxlength = "14" value= "0094" style = "width: 125px;" onBlur = "validatePhoneNumber(this, \'Fax\');" /></td> ' + 
                       '           <td><input class = "txt_input" type = "text" name = "TXT_S10_EMAIL_' + m_new_total_count + '" maxlength = "100" style = "width: 175px;" onBlur ="validateEmail(this);" /></td> ' + 
                       '       </tr> ' + 
                       '   </table> ' + 
                       '   <table> ' + 
                       '       <tr> ' + 
                       '           <td style = "width: 50px;"></td> ' + 
                       '           <td style = "width: 50px;"></td> ' + 
                       '           <td class = "div_input" align = "center" colspan = "4"><div id = "DIV_TXT_S10_CONTACT_PERSON_' + m_new_total_count + '"><b>Contact person</b></td> ' + 
                       '       </tr> ' + 
                       '       <tr> ' + 
                       '           <td style = "width: 50px;"></td> ' + 
                       '           <td style = "width: 50px;"></td> ' + 
                       '           <td class = "div_input" align = "center" style = "width: 75px;"><div id = "DIV_TXT_S10_TITLE_2_' + m_new_total_count + '"><b>Title</b></td> ' + 
                       '           <td class = "div_input" align = "center" style = "width: 125px;"><div id = "DIV_TXT_S10_LAST_NAME_2_' + m_new_total_count + '"><b>Last Name</b></td> ' + 
                       '           <td class = "div_input" align = "center" style = "width: 75px;"><div id = "DIV_TXT_S10_INITIALS_2_' + m_new_total_count + '"><b>Initials</b></td> ' + 
                       '           <td class = "div_input" align = "center" style = "width: 250px;"><div id = "DIV_TXT_S10_INITIALS_DETAILS_2_' + m_new_total_count + '"><b>Name Denoted by Initials</b></td> ' + 
                       '       </tr> ' + 
                       '       <tr> ' + 
                       '           <td style = "width: 50px;"></td> ' + 
                       '           <td style = "width: 50px;"></td> ' + 
                       '           <td><select class = "txt_input" name="TXT_S10_TITLE_2_' + m_new_total_count + '" style = "width: 75px;" /> ' + m_types_title + ' </select></td> ' + 
                       '           <td><input class = "txt_input" type = "text" name = "TXT_S10_LAST_NAME_2_' + m_new_total_count + '" maxlength = "100" style = "width: 125px;" onBlur = "strTrim(this, null, null, \'NAME\'); strProperCase(this);" /></td> ' + 
                       '           <td><input class = "txt_input" type = "text" name = "TXT_S10_INITIALS_2_' + m_new_total_count + '" maxlength = "30" style = "width: 75px;" onBlur = "strTrim(this);" /></td> ' + 
                       '           <td><input class = "txt_input" type = "text" name = "TXT_S10_INITIALS_DETAILS_2_' + m_new_total_count + '" maxlength = "400" style = "width: 250px;" onBlur = "strTrim(this, null, null, \'NAME\'); strProperCase(this); setInitials(this, document.Form1.elements[\'TXT_S10_INITIALS_2_' + m_new_total_count + '\']);" /></td> ' + 
                       '       </tr> ' + 
                       '   </table> ' + 
                       '   <table> ' + 
                       '       <tr> ' + 
                       '           <td style = "width: 50px;"></td> ' + 
                       '           <td style = "width: 50px;"></td> ' + 
                       '           <td class = "div_input" align = "center" style = "width: 125px;"><div id = "DIV_TXT_S10_RELATION_' + m_new_total_count + '"><b>Relation (Yrs.)</b></td> ' + 
                       '           <td class = "div_input" align = "center" style = "width: 250px;"><div id = "DIV_TXT_S10_COMMENTS_' + m_new_total_count + '"><b>Comments</b></td> ' + 
                       '           <td class = "div_input" align = "center" style = "width: 175px;"><div id = "DIV_TXT_S10_CREDIT_PERIOD_RECEIVED_' + m_new_total_count + '"><b>Cr. Period Received(Months)</b></td> ' + 
                       '           <td class = "div_input" align = "center" style = "width: 175px;"><div id = "DIV_TXT_S10_SECURITY_' + m_new_total_count + '"><b>Security</b></td> ' + 
                       '       </tr> ' + 
                       '       <tr> ' + 
                       '           <td style = "width: 50px;"></td> ' + 
                       '           <td style = "width: 50px;"></td> ' + 
                       '           <td><input class = "txt_input" type = "text" name = "TXT_S10_RELATION_' + m_new_total_count + '" value = "0.0" maxlength = "5" style = "width: 125px; text-align: right;" onBlur = "validateNumber(this, 0, 999.9, 1, \'number\')" /></td> ' + 
                       '           <td><input class = "txt_input" type = "text" name = "TXT_S10_COMMENTS_' + m_new_total_count + '" maxlength = "4000" style = "width: 250px;" onBlur = "strTrim(this);" /></td> ' + 
                       '           <td><input class = "txt_input" type = "text" name = "TXT_S10_CREDIT_PERIOD_RECEIVED_' + m_new_total_count + '" value = "0.0" maxlength = "5" style = "width: 175px; text-align: right;" onBlur = "validateNumber(this, 0, 999.9, 1, \'number\')" /></td> ' + 
                       '           <td><input class = "txt_input" type = "text" name = "TXT_S10_SECURITY_' + m_new_total_count + '" value = "0.00" maxlength = "24" style = "width: 175px; text-align: right;" onBlur = "validateNumber(this, 0, 9999999999999999.99, 2, \'number\')" /></td> ' + 
                       '       </tr> ' + 
                       '   </table> '; 
               }
               else {
                   document.getElementById("DIV_SUPPLIERS_CUSTOMERS_DETAILS" + m_new_total_count).innerHTML = '' + 
                       '   <table> ' + 
                       '       <tr> ' + 
                       '           <td class = "div_input" align = "center" style = "width: 50px;"></td> ' + 
                       '           <td class = "div_input" align = "center" style = "width: 50px;"></td> ' + 
                       '           <td class = "div_input" align = "center" style = "width: 125px;"><b>Supplier Type</b></td> ' + 
                       '           <td class = "div_input" align = "center" style = "width: 250px;"><div id = "DIV_TXT_S10_COMPANY_NAME_' + m_new_total_count + '"><b>Company Name</b></div></td> ' + 
                       '       </tr> ' + 
                       '       <tr> ' + 
                       '           <td style = "width: 50px;"></td> ' + 
                       '           <td><input class = "but_input" type = "button" name = "BUT_DELETE_SUPPLIERS_CUSTOMERS_DETAILS" value = "-" onClick = "delete_suppliers_customers_details(' + m_new_total_count + ');" /></td> ' + 
                       '           <td><select class = "txt_input" name="TXT_S10_CUSTOMER_TYPE_' + m_new_total_count + '" style = "width: 125px;" onChange = "hideCompanyNameLabel(' + m_new_total_count + ')" /><option value = "C">Corporate</option><option value = "I">Individual</option></select></td> ' + 
                       '           <td><input class = "txt_input" type = "text" name = "TXT_S10_COMPANY_NAME_' + m_new_total_count + '" maxlength = "100" style = "width: 250px;" onBlur = "strTrim(this, null, null, \'NAME\'); strProperCase(this);" /></td> ' + 
                       '       </tr> ' + 
                       '   </table> ' + 
                       '   <table> ' + 
                       '       <tr> ' + 
                       '           <td style = "width: 50px;"></td> ' + 
                       '           <td style = "width: 50px;"></td> ' + 
                       '           <td class = "div_input" align = "center" style = "width: 175px;"><b>Type</b></td> ' + 
                       '           <td class = "div_input" align = "center" style = "width: 75px;"><b>Title</b></td> ' + 
                       '           <td class = "div_input" align = "center" style = "width: 125px;"><b>Last Name</b></td> ' + 
                       '           <td class = "div_input" align = "center" style = "width: 75px;"><b>Initials</b></td> ' + 
                       '           <td class = "div_input" align = "center" style = "width: 250px;"><b>Name Denoted by Initials</b></td> ' + 
                       '       </tr> ' + 
                       '       <tr> ' + 
                       '           <td style = "width: 50px;"></td> ' + 
                       '           <td style = "width: 50px;"></td> ' + 
                       '           <td><select class = "txt_input" name="TXT_S10_TYPE_' + m_new_total_count + '" style = "width: 175px;" /> ' + m_types_supplier_or_customer + ' </select></td> ' + 
                       '           <td><select class = "txt_input" name="TXT_S10_TITLE_' + m_new_total_count + '" style = "width: 75px;" /> ' + m_types_title + ' </select></td> ' + 
                       '           <td><input class = "txt_input" type = "text" name = "TXT_S10_LAST_NAME_' + m_new_total_count + '" maxlength = "100" style = "width: 125px;" onBlur = "strTrim(this, null, null, \'NAME\'); strProperCase(this);" /></td> ' + 
                       '           <td><input class = "txt_input" type = "text" name = "TXT_S10_INITIALS_' + m_new_total_count + '" maxlength = "30" style = "width: 75px;" onBlur = "strTrim(this);" /></td> ' + 
                       '           <td><input class = "txt_input" type = "text" name = "TXT_S10_INITIALS_DETAILS_' + m_new_total_count + '" maxlength = "400" style = "width: 250px;" onBlur = "strTrim(this, null, null, \'NAME\'); strProperCase(this); setInitials(this, document.Form1.elements[\'TXT_S10_INITIALS_' + m_new_total_count + '\']);" /></td> ' + 
                       '       </tr> ' + 
                       '   </table> ' + 
                       '   <table> ' + 
                       '       <tr> ' + 
                       '           <td style = "width: 50px;"></td> ' + 
                       '           <td style = "width: 50px;"></td> ' + 
                       '           <td class = "div_input" align = "center" style = "width: 125px;"><b>Address Type</b></td> ' + 
                       '           <td class = "div_input" align = "center" style = "width: 125px;"><b>Ownership</b></td> ' + 
                       '           <td class = "div_input" align = "center" style = "width: 250px;"><b>Address Line 1</b></td> ' + 
                       '           <td class = "div_input" align = "center" style = "width: 250px;"><b>Address Line 2</b></td> ' + 
                       '       </tr> ' + 
                       '       <tr> ' + 
                       '           <td style = "width: 50px;"></td> ' + 
                       '           <td style = "width: 50px;"></td> ' + 
                       '           <td><select class = "txt_input" name="TXT_S10_ADDRESS_TYPE_' + m_new_total_count + '" style = "width: 125px;" /> ' + m_types_address + ' </select></td> ' + 
                       '           <td><select class = "txt_input" name="TXT_S10_OWNERSHIP_' + m_new_total_count + '" style = "width: 125px;" /> ' + m_types_ownership + ' </select></td> ' + 
                       '           <td><input class = "txt_input" type = "text" name = "TXT_S10_ADDRESS_LINE_1_' + m_new_total_count + '" maxlength = "100" style = "width: 250px;" onBlur = "strTrim(this, null, null, \'ADDRESS\'); strProperCase(this);" /></td> ' + 
                       '           <td><input class = "txt_input" type = "text" name = "TXT_S10_ADDRESS_LINE_2_' + m_new_total_count + '" maxlength = "100" style = "width: 250px;" onBlur = "strTrim(this, null, null, \'ADDRESS\'); strProperCase(this);" /></td> ' + 
                       '       </tr> ' + 
                       '   </table> ' + 
                       '   <table> ' + 
                       '       <tr> ' + 
                       '           <td style = "width: 50px;"></td> ' + 
                       '           <td style = "width: 50px;"></td> ' + 
                       '           <td class = "div_input" align = "center" style = "width: 175px;"><b>City</b></td> ' + 
                       '           <td class = "div_input" align = "center" style = "width: 125px;"><b>District</b></td> ' + 
                       '           <td class = "div_input" align = "center" style = "width: 125px;"><b>Province</b></td> ' + 
                       '           <td class = "div_input" align = "center" style = "width: 125px;"><b>Country</b></td> ' + 
                       '       </tr> ' + 
                       '       <tr> ' + 
                       '           <td style = "width: 50px;"></td> ' + 
                       '           <td style = "width: 50px;"></td> ' + 
                       '           <td> ' + 
                       '               <input type = "hidden" name = "TXT_S10_CITY_' + m_new_total_count + '" /> ' + 
                       '               <input class = "txt_input" type = "text" name = "TXT_S10_CITY_NAME_' + m_new_total_count + '" maxlength = "50" onBlur = "strTrim(this); help_update_s10_city(\'help_update_s10_city_' + m_new_total_count + '\', ' + '\'' + m_new_total_count + '\');" style = "width: 125px;" /> ' + 
                       '               <input class = "but_input" type = "button" name = "BUT_HELP_S10_CITY" value = "..." onClick = "help_update_s10_city(\'help_update_s10_city_' + m_new_total_count + '\', ' + '\'' + m_new_total_count + '\');" /><a id = "help_update_s10_city_' + m_new_total_count + '" style = "{text-decoration: none; cursor: text;}" class = "fancylink iframe" href = "" > </a> ' + 
                       '           </td> ' + 
                       '           <td><input class = "txt_input" type = "text" name = "TXT_S10_DISTRICT_NAME_' + m_new_total_count + '" disabled = "disabled" style = "width: 125px;" /></td> ' + 
                       '           <td><input class = "txt_input" type = "text" name = "TXT_S10_PROVINCE_NAME_' + m_new_total_count + '" disabled = "disabled" style = "width: 125px;" /></td> ' + 
                       '           <td><input class = "txt_input" type = "text" name = "TXT_S10_COUNTRY_NAME_' + m_new_total_count + '" disabled = "disabled" style = "width: 125px;" /></td> ' + 
                       '       </tr> ' + 
                       '   </table> ' + 
                       '   <table> ' + 
                       '       <tr> ' + 
                       '           <td style = "width: 50px;"></td> ' + 
                       '           <td style = "width: 50px;"></td> ' + 
                       '           <td class = "div_input" align = "center" style = "width: 125px;"><b>Telephone 1</b></td> ' + 
                       '           <td class = "div_input" align = "center" style = "width: 125px;"><b>Telephone 2</b></td> ' + 
                       '           <td class = "div_input" align = "center" style = "width: 125px;"><b>Mobile</b></td> ' + 
                       '           <td class = "div_input" align = "center" style = "width: 125px;"><b>Fax</b></td> ' + 
                       '           <td class = "div_input" align = "center" style = "width: 175px;"><b>Email</b></td> ' + 
                       '       </tr> ' + 
                       '       <tr> ' + 
                       '           <td style = "width: 50px;"></td> ' + 
                       '           <td style = "width: 50px;"></td> ' + 
                       '           <td><input class = "txt_input" type = "text" name = "TXT_S10_TELEPHONE_1_' + m_new_total_count + '" maxlength = "14" value= "0094" style = "width: 125px;" onBlur = "validatePhoneNumber(this, \'Telephone\');" /></td> ' + 
                       '           <td><input class = "txt_input" type = "text" name = "TXT_S10_TELEPHONE_2_' + m_new_total_count + '" maxlength = "14" value= "0094" style = "width: 125px;" onBlur = "validatePhoneNumber(this, \'Telephone\');" /></td> ' + 
                       '           <td><input class = "txt_input" type = "text" name = "TXT_S10_MOBILE_' + m_new_total_count + '" maxlength = "14" value= "0094" style = "width: 125px;" onBlur = "validatePhoneNumber(this, \'Mobile\');" /></td> ' + 
                       '           <td><input class = "txt_input" type = "text" name = "TXT_S10_FAX_' + m_new_total_count + '" maxlength = "14" value= "0094" style = "width: 125px;" onBlur = "validatePhoneNumber(this, \'Fax\');" /></td> ' + 
                       '           <td><input class = "txt_input" type = "text" name = "TXT_S10_EMAIL_' + m_new_total_count + '" maxlength = "100" style = "width: 175px;" onBlur ="validateEmail(this);" /></td> ' + 
                       '       </tr> ' + 
                       '   </table> ' + 
                       '   <table> ' + 
                       '       <tr> ' + 
                       '           <td style = "width: 50px;"></td> ' + 
                       '           <td style = "width: 50px;"></td> ' + 
                       '           <td class = "div_input" align = "center" colspan = "4"><div id = "DIV_TXT_S10_CONTACT_PERSON_' + m_new_total_count + '"><b>Contact person</b></td> ' + 
                       '       </tr> ' + 
                       '       <tr> ' + 
                       '           <td style = "width: 50px;"></td> ' + 
                       '           <td style = "width: 50px;"></td> ' + 
                       '           <td class = "div_input" align = "center" style = "width: 75px;"><div id = "DIV_TXT_S10_TITLE_2_' + m_new_total_count + '"><b>Title</b></td> ' + 
                       '           <td class = "div_input" align = "center" style = "width: 125px;"><div id = "DIV_TXT_S10_LAST_NAME_2_' + m_new_total_count + '"><b>Last Name</b></td> ' + 
                       '           <td class = "div_input" align = "center" style = "width: 75px;"><div id = "DIV_TXT_S10_INITIALS_2_' + m_new_total_count + '"><b>Initials</b></td> ' + 
                       '           <td class = "div_input" align = "center" style = "width: 250px;"><div id = "DIV_TXT_S10_INITIALS_DETAILS_2_' + m_new_total_count + '"><b>Name Denoted by Initials</b></td> ' + 
                       '       </tr> ' + 
                       '       <tr> ' + 
                       '           <td style = "width: 50px;"></td> ' + 
                       '           <td style = "width: 50px;"></td> ' + 
                       '           <td><select class = "txt_input" name="TXT_S10_TITLE_2_' + m_new_total_count + '" style = "width: 75px;" /> ' + m_types_title + ' </select></td> ' + 
                       '           <td><input class = "txt_input" type = "text" name = "TXT_S10_LAST_NAME_2_' + m_new_total_count + '" maxlength = "100" style = "width: 125px;" onBlur = "strTrim(this, null, null, \'NAME\'); strProperCase(this);" /></td> ' + 
                       '           <td><input class = "txt_input" type = "text" name = "TXT_S10_INITIALS_2_' + m_new_total_count + '" maxlength = "30" style = "width: 75px;" onBlur = "strTrim(this);" /></td> ' + 
                       '           <td><input class = "txt_input" type = "text" name = "TXT_S10_INITIALS_DETAILS_2_' + m_new_total_count + '" maxlength = "400" style = "width: 250px;" onBlur = "strTrim(this, null, null, \'NAME\'); strProperCase(this); setInitials(this, document.Form1.elements[\'TXT_S10_INITIALS_2_' + m_new_total_count + '\']);" /></td> ' + 
                       '       </tr> ' + 
                       '   </table> ' + 
                       '   <table> ' + 
                       '       <tr> ' + 
                       '           <td style = "width: 50px;"></td> ' + 
                       '           <td style = "width: 50px;"></td> ' + 
                       '           <td class = "div_input" align = "center" style = "width: 125px;"><div id = "DIV_TXT_S10_RELATION_' + m_new_total_count + '"><b>Relation (Yrs.)</b></td> ' + 
                       '           <td class = "div_input" align = "center" style = "width: 250px;"><div id = "DIV_TXT_S10_COMMENTS_' + m_new_total_count + '"><b>Comments</b></td> ' + 
                       '           <td class = "div_input" align = "center" style = "width: 175px;"><div id = "DIV_TXT_S10_CREDIT_PERIOD_RECEIVED_' + m_new_total_count + '"><b>Cr. Period Received(Months)</b></td> ' + 
                       '           <td class = "div_input" align = "center" style = "width: 175px;"><div id = "DIV_TXT_S10_SECURITY_' + m_new_total_count + '"><b>Security</b></td> ' + 
                       '       </tr> ' + 
                       '       <tr> ' + 
                       '           <td style = "width: 50px;"></td> ' + 
                       '           <td style = "width: 50px;"></td> ' + 
                       '           <td><input class = "txt_input" type = "text" name = "TXT_S10_RELATION_' + m_new_total_count + '" value = "0.0" maxlength = "5" style = "width: 125px; text-align: right;" onBlur = "validateNumber(this, 0, 999.9, 1, \'number\')" /></td> ' + 
                       '           <td><input class = "txt_input" type = "text" name = "TXT_S10_COMMENTS_' + m_new_total_count + '" maxlength = "4000" style = "width: 250px;" onBlur = "strTrim(this);" /></td> ' + 
                       '           <td><input class = "txt_input" type = "text" name = "TXT_S10_CREDIT_PERIOD_RECEIVED_' + m_new_total_count + '" value = "0.0" maxlength = "5" style = "width: 175px; text-align: right;" onBlur = "validateNumber(this, 0, 999.9, 1, \'number\')" /></td> ' + 
                       '           <td><input class = "txt_input" type = "text" name = "TXT_S10_SECURITY_' + m_new_total_count + '" value = "0.00" maxlength = "24" style = "width: 175px; text-align: right;" onBlur = "validateNumber(this, 0, 9999999999999999.99, 2, \'number\')" /></td> ' + 
                       '       </tr> ' + 
                       '   </table> '; 
               }
               document.Form1.hid_suppliers_customers_details_count.value = m_new_total_count;
               hideCompanyNameLabel(m_new_total_count);
               init_fancybox();
           }

