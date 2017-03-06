
	var query = {
		age:10
	};

	$.ajax({
		url:url,
		data:JSON.stringify(query),
		type:'post',
		contentType:'application/json;charset=utf-8',
		dataType:'json',
		success: function (json) {
			alert(json)
		}
	});

springMVC 接收时要加@ResquestBody 传输的json字符串

        var query = {
            age:10
        };

        $.ajax({
            url:url,
            data:query,
            type:'post',
            dataType:'json',
            success: function (json) {
                alert(json)
            }
        });

springMVC 接收时不加@ResquestBody 传输的form表单
