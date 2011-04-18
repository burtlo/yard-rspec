function rspecSearchFrameLinks() {
    $('#spec_list_link').click(function() {
        toggleSearchFrame(this, relpath + 'spec_list.html');
    });
}

function rspecKeyboardShortcuts() {
    if (window.top.frames.main) return;
    $(document).keypress(function(evt) {
        if (evt.altKey || evt.ctrlKey || evt.metaKey || evt.shiftKey) return;
        if (typeof evt.orignalTarget !== "undefined" &&  
        (evt.originalTarget.nodeName == "INPUT" || 
        evt.originalTarget.nodeName == "TEXTAREA")) return;
        switch (evt.charCode) {
            case 83: case 115: $('#spec_list_link').click(); break; // 's'
        }
    });
}

$(rspecSearchFrameLinks);
$(rspecKeyboardShortcuts);

$(function() {
    
    $('.specification').each(function(index,element) {
        toggleSpecification($(element).parent());
    });
    
    //
    //  When the title of a Context - Specification is clicked we want to 
    // find the parent element and perform the operations of 'toggleSpecifications' 
    //
    $('.specification').click(function(eventObject) {
        if (typeof eventObject.currentTarget !== "undefined")  {
            toggleSpecification( $($(eventObject.currentTarget).parent()) );
        }
    });

    
    $('.context .title').click(function(eventObject) {
        if (typeof eventObject.currentTarget !== "undefined")  {
            toggleAllSpecifications( $($(eventObject.currentTarget).parent()) );
        }
    });

});

function toggleAllSpecifications(context) {
    
    var state = context.find(".attributes input[name='collapsed']")[0];
    
    if (state.value === 'true') {
        context.find(".specification").each(function() {
            toggleSpecification($(this).parent());
        });

        state.value = "false";
		
    } else {
        context.find(".specification").each(function() {
            toggleSpecification($(this).parent());
        });

        state.value = "true";
    }
    
}

function toggleSpecification(specification) {
	
    var state = specification.find(".attributes input[name='collapsed']")[0];
	
    if (state.value === 'true') {
        specification.find("div.details").each(function() {
            $(this).show(100);
        });
        // Automatically show the source code when the specification is toggled 
        // open this is normally hidden by the YARD javascript properties.
        specification.find(".source_code").each(function() {
           $(this).show(100); 
        });
        
        state.value = "false";
		
    } else {
        specification.find("div.details").each(function() {
            $(this).hide(100);
        });
        
        state.value = "true";
    }
}