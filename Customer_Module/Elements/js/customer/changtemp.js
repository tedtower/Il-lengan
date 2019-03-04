$('#hot-or-cold').on('click' , function(){
    if($('#hot-or-cold').is(':checked')){
        text = 'Hot';
    }else if($('#hot-or-cold').not(':checked')){
        text = 'Cold';
    }
    $('#temp').html(text);
});
$('#edit-temp').on('click' , function(){
    if($('#edit-temp').is(':checked')){
        text = 'Hot';
    }else if($('#edit-temp').not(':checked')){
        text = 'Cold';
    }
    $('#edtemp').html(text);
});