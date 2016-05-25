<cfscript>
/**
* Returns extension defined by all characters following last period.
* v2 by Ray Camden
*
* @param name      File name to use. (Required)
* @return Returns a string.
* @author Alexander Sicular (as867@columbia.edu)
* @version 2, May 9, 2003
*/
function getExtension(name) {
if(find(".",name)) return listLast(name,".");
else return "";
}
/**
* Escapes all regular expression &amp;quot;special characters&amp;quot; in a string with &amp;quot;\&amp;quot;.
* 
* @param theString      The string to format. (Required)
* @return Returns a string. 
* @author Shawn Seley (shawnse@aol.com) 
* @version 1, June 26, 2002 
function REEscape(theString){
    var special_char_list = "\,+,*,?,.,[,],^,$,(,),{,},|,-";
    var esc_special_char_list = "\\,\+,\*,\?,\.,\[,\],\^,\$,\(,\),\{,\},\|,\-";
    return ReplaceList(theString, special_char_list, esc_special_char_list);
}
*/

</cfscript>





