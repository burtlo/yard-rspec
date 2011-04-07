function rspecSearchFrameLinks() {
    $('#specs_list_link').click(function() {
        toggleSearchFrame(this, relpath + 'specs_list.html');
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
      case 83: case 115: $('#specs_list_link').click(); break; // 's'
    }
  });
}

$(rspecSearchFrameLinks);
$(rspecKeyboardShortcuts);