var Ajax;
if (Ajax && (Ajax != null)) {
	Ajax.Responders.register({
	  onCreate: function() {
        if($('spinner') && Ajax.activeRequestCount>0)
          Effect.Appear('spinner',{duration:0.5,queue:'end'});
	  },
	  onComplete: function() {
        if($('spinner') && Ajax.activeRequestCount==0)
          Effect.Fade('spinner',{duration:0.5,queue:'end'});
	  }
	});
}

function setFocusOnFirstControl(){
	// set focus on first control of the form
	var bFound = false; 
	var noOfInputElements = document.getElementsByTagName("input").length;
	
	for(i=0; i < noOfInputElements; i++)
	{
	  if (document.getElementsByTagName("input")[i].type != "hidden")
	  {
	    if (document.getElementsByTagName("input")[i].disabled != true)
	    {
	        document.getElementsByTagName("input")[i].focus();
	        var bFound = true;
	    }
	  }
	  if (bFound == true)
	    break;
	}
}