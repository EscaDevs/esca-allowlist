window.addEventListener("message", function(event) {

    var data = event.data;
    

    switch (event.data.action) {
        case "openUI":
            $('.form').show()
            $(".loginnotify").empty();
            var html = `<p style='font-weight: 500;'>Login</p>`
            $(".loginnotify").append(html);
        break;

        case "closeUI":
            $('.form').hide();
        break;

        case "success":
            $('.menu').show()
            $('.form').hide()
            $('.list').hide()

            $(".addnotify").empty();
            var hex = $("#hex").val()
            var html = ` <p style='font-weight: 500;'>Allowlist</p>`
            $(".addnotify").append(html);
        break;                
            
        case "kapat":
            $('.menu').hide()
            $('.form').hide()
            $('.list').hide()
        break;  
                  
        case "list":
            var list = data.db
            $(".whlist").empty()

            $.each(list, function(index, item){
                var html = 
                `<div class="wh ${item.hex}"> 
                    <p><strong>Hex: <a style="color:rgb(255, 255, 255)">${item.hex}</a></p>
                    <p><strong>User: <a style="color:rgb(255, 255, 255)">${item.nickname}</a> / Admin: <a style="color:rgb(255, 255, 255)">${item.adminname}</a></p>
                    <p><strong>Last Online: <a style="color:rgb(255, 255, 255)">${item.lastonline}</a></p>
                    <button class="removewl" hex="${item.hex}" type="button">Remove</button>
                </div>`
                $(".whlist").append(html);
            });
            $('.menu').hide()
            $('.form').hide()
            $('.list').show()
        break;

        case "addsucces":
            $(".addnotify").empty();
            var hex = $("#hex").val()
            var html = ` <p style='color: #1f6d15; font-weight: 500;'>Successfully Added</p>`
            $(".addnotify").append(html);

            $("#hex").val($("#hex").data('placeholder'));
            $("#nick").val($("#nick").data('placeholder'));

        break;

        case "adderror_auth":
            $(".addnotify").empty();
            var html = ` <p style='color: #6d2715; font-weight: 500;'>You authorization is not enough</p>`
            $(".addnotify").append(html);

            $("#hex").val($("#hex").data('placeholder'));
            $("#nick").val($("#nick").data('placeholder'));

        break;

        case "adderror_already":
            $(".addnotify").empty();
            var html = ` <p style='color: #6d2715; font-weight: 500;'>Already allowlisted</p>`
            $(".addnotify").append(html);

            $("#hex").val($("#hex").data('placeholder'));
            $("#nick").val($("#nick").data('placeholder'));

        break;

        case "removed":
            $('.confirm').hide();
            $('.'+data.hex).remove();
        break;

        case "notremoved":
            $(".confirm").empty()

            var html = 
            `<div class="popup">
                <h1>Allowlist Delete</h1>
                <p style='color: #6d2715;'>You authorization is not enough</p>
                <button class="cancel">CLOSED</button>
            </div>`
            $(".confirm").append(html);
        break;

        case "error_username":
            $(".loginnotify").empty();
            var html = ` <p style='color: #9c1e1e; font-weight: 500;'>Username is wrong</p>`
            $(".loginnotify").append(html);
        break;

        case "error_password":
            $(".loginnotify").empty();
            var html = ` <p style='color: #9c1e1e; font-weight: 500;'>Password is wrong</p>`
            $(".loginnotify").append(html);
        break;
    }
});



$('document').ready(function() {
    $('.form').hide()
    $('.menu').hide()
    $('.list').hide()
    $('.confirm').hide()

    document.onkeydown = function(data) {
        if (data.which == 27) {
            $.post('https://esca-allowlist/close');
        }
    };

});

$(".list .box .container-4 .icon").click(function(e) {
    var label = $(".wh-search").val();
    $(".wh").filter(function() {
        $(this).toggle($(this).text().indexOf(label) > -1)
    });

});


$(".login").click(function(e) {
    $.post('https://esca-allowlist/login', JSON.stringify({
        usernam: $("#usernam").val(),
        pass: $("#pass").val(),
    }));
    usernam = $("#usernam").val();
    pass = $("#pass").val();
});

$(".add").click(function(e) {
    if ($("#hex").val() == ""){
        $(".addnotify").empty();
        var html = ` <p style='color: #6d2715; font-weight: 500;'>Hex can not empty</p>`
        $(".addnotify").append(html);
    }else{
        $.post('https://esca-allowlist/add', JSON.stringify({
            hex: $("#hex").val(),
            nick: $("#nick").val()
        }));
    }
});

$(".closelogo").click(function (e) { 
    $.post('https://esca-allowlist/close');
});

$(".backbutton").click(function (e) { 
    $('.menu').show()
    $('.list').hide()
});

$(".list1").click(function(e) {
    $.post('https://esca-allowlist/list', JSON.stringify({
    }));
});

$(".reload").click(function(e) {
    $(".addnotify").empty();
    var hex = $("#hex").val()
    var html = ` <p style='color: #1f6d15; font-weight: 500;'>Allowlist refreshed</p>`
    $(".addnotify").append(html);
    $.post('https://esca-allowlist/reload', JSON.stringify({
    }));
});

$(document).on("click",".removewl",function(e) {
    var hex = $(this).attr("hex");

    $(".confirm").empty()

    var html = 
    `<div class="popup">
        <h1>Allowlist Delete</h1>
        <p>Are you sure want to delete? HEX: ${hex}</p>
        <button class="cancel">CANCEL</button>
        <button hex="${hex}" class="delete" autofocus>DELETE</button>
    </div>`
    $(".confirm").append(html);
    $('.confirm').show();

});

$(document).on("click",".cancel",function(e) {
    $('.confirm').hide();
    
});

$(document).on("click",".delete",function(e) {
    var hex = $(this).attr("hex");
    $.post('https://esca-allowlist/remove', JSON.stringify({
        hex: hex
    }));
});
