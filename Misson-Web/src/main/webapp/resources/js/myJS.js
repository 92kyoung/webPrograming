/**
 *  등록과 관련된 JS
 */
function isNull(obj,msg){
	if(obj.value==''){
		alert(msg)
		obj.focus()
		return true
	}
		return false
}
