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
    $('.specification .heading').click(function(eventObject) {
        if (typeof eventObject.currentTarget !== "undefined")  {
            toggleSpecification( $($(eventObject.currentTarget).parent()) );
        }
    });

    
    $('.context .title span').click(function(eventObject) {
        if (typeof eventObject.currentTarget !== "undefined")  {
            toggleAllSpecifications( $($(eventObject.currentTarget).parent().parent()) );
        }
    });

});

function toggleAllSpecifications(context) {

    // Count the the specifications
    // If the number of visible specifications equal to the total then we
    // we want to hide all
    // If the number of hidden specifications equal to the total then we 
    // want to show all
    // Otherwise we are going to rely on the toggle
    //

    var allSpecs = context.find('.specification');

    var hiddenSpecs = context.find('.specification .details:hidden');
    var visibleSpecs = context.find('.specification .details:visible');

    if ( allSpecs.length == hiddenSpecs.length ) {
        console.log('Showing all files')
        allSpecs.each(function(index, element) { showSpecification( $(element).parent() ) } );
    } else if ( allSpecs.length == visibleSpecs.length ) {
        console.log('Hiding All Files')
        allSpecs.each(function(index, element) { hideSpecification( $(element).parent() ) } );
    } else {

        var state = context.children('.attributes').find('input[name="collapsed"]')[0];
        console.log(state);
        
        if (state.value === 'false') {
            console.log('Showing Files');
            hiddenSpecs.each(function(index, element) {
                showSpecification( $(element).parent() );
            });
            
            state.value = 'true'
        } else {
            console.log('Hiding Files');
            visibleSpecs.each(function(index, element) { 
                hideSpecification( $(element).parent() ); 
            });
            
            state.value = 'false'
        }

    }


}

function showSpecification(specification) {
    
    var state = specification.find(".attributes input[name='collapsed']")[0];
    
    console.log('show');
    console.log(specification);
    
    specification.find("div.details").each(function() {
        $(this).show(100);
    });
    // Automatically show the source code when the specification is toggled 
    // open this is normally hidden by the YARD javascript properties.
    specification.find(".source_code").each(function() {
       $(this).show(100); 
    });
    
    state.value = "false";
    
}

function hideSpecification(specification) {
    
    var state = specification.find(".attributes input[name='collapsed']")[0];
    
    console.log('hide');
    console.log(specification);
    
    specification.find("div.details").each(function() {
        $(this).hide(100);
    });
    
    state.value = "true";
}

function toggleSpecification(specification) {
	
    var state = specification.find(".attributes input[name='collapsed']")[0];
	
    if (state.value === 'true') {
        showSpecification(specification);
    } else {
        hideSpecification(specification)
    }
    
    console.log("value: " + specification.find(".attributes input[name='collapsed']")[0].value);
    
}