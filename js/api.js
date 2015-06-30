var currentData;
var config;
var editor_template;
var editor_css;
CodeMirror.defineMode("htmlhandlebars", function(config) {
    return CodeMirror.multiplexingMode(CodeMirror.getMode(config, "text/html"), {
	     open: "{{", close: "}}",
	     mode: CodeMirror.getMode(config, "handlebars"),
	     parseDelimiters: true
    });
});
function init() {
	$.getJSON('config.json', function(data) {
		config = data;
		$('title').html(config.title);
		$('.container-fluid').prepend($('<h1></h1>').append(config.icon).append(" " ).append(config.title));
		$('#token-form').attr('action', config.auth_url);
		$('#redirect_uri').val(config.redirect_url);
		$('#client_id').val(config.client_id);
		parseAccessKey();
  	});
}

function attachEventHandlers() {
	$('.btn-primary').click(function(e) {
		query(e);
	});
	$('.update-template').click(function(e) {
		query(e);
	});

	$('label').click(checker);
	$('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
  		showEditableTemplate();
  		reload();
	});
}

function showEditableTemplate() {
	var template_id = $('.tab-pane.active').attr('template-id');
	var height = 200;
	if(!editor_css) {
		$('#edit-style').val($('#custom-styles').html());	
		editor_css = CodeMirror.fromTextArea(document.getElementById("edit-style"), {
			mode: "text/css",
			styleActiveLine: true,
			lineNumbers: true,
			theme: "api-tester",
			lineWrapping: true,
			foldGutter: true,
			height: 100,
			gutters: ["CodeMirror-linenumbers", "CodeMirror-foldgutter"]
    	});
    	editor_css.setSize('auto', height);
	} else {
		editor_css.setValue($('#custom-styles').html());
	}
    
    if(!editor_template) {
		$('#edit-template').val($('#' + template_id).html());	
    	editor_template = CodeMirror.fromTextArea(document.getElementById("edit-template"), {
			mode: "htmlhandlebars",
			styleActiveLine: true,
			lineNumbers: true,
			theme: "api-tester",
			height: "100px",
			lineWrapping: true
    	});
    	editor_template.setSize('auto', height);
    } else {
    	editor_template.setValue($('#' + template_id).html());
    }
}

function query(e) {
	var d = {};
	var url = $('.tab-pane.active').find('input').val();
	if (config.jsonp) {
		 url += (url.indexOf("?") == -1) ? '?callback=?' : '&callback=?';
	}
	if (config.include_client_id) {
		d["client_id"] = config.client_id;
	}
	if (config.include_access_token) {
		d[config.access_token] = localStorage.getItem(config.id + '_access_token');
	}
	$.getJSON(url, d)
		.done(function( data ) {
			var $el = $('.tab-pane.active').find('.display-results');
    	 	genericCallback($el, data);
  		});
  	if (e) {
		e.preventDefault();
  	}
}

function genericCallback($el, data, f) {
	var $pre;
	currentData = data;
	$el.empty();
	switch($('input[name=status]:checked').val()) {
		case '0':
			$el.html(JSON.stringify(data));
			break;
		case '1':
			$pre = $('<pre class="prettyprint"></pre>');
			$el.append($pre);
			$pre.html(JSON.stringify(data, null, 3));
			prettyPrint();
 			urlize($el);
 			//photoify($el);
 			break;
		case '2':
			var template_id = $('.tab-pane.active').attr('template-id');
			if (template_id) {
				var $row = $("<div />").addClass("row");
				var template = Handlebars.compile(editor_template.getValue());
				$('#custom-styles').html(editor_css.getValue());
				$row.append(template(data));
				$el.append($row);
			} else {
				$el.html(JSON.stringify(data, null, 3));
				prettyPrint();
	 			photoify($el);
			}
 			break;
	}
}

function parseAccessKey() {
	var access_token = window.location.href.split('=')[1];
	if (access_token) {
		//trim off any additional parameters:
		access_token = access_token.split('&')[0]; 
		localStorage.setItem(config.id + '_access_token', access_token);
		showApiTester(access_token);
		window.location = window.location.href.split('#')[0];
	} else {
		getAccessKey();
	}
}

function getAccessKey() {
	//localStorage.removeItem(config.id + '_access_token');
	var access_token = localStorage.getItem(config.id + '_access_token');
	if (access_token) {
		showApiTester(access_token);
		showEditableTemplate();
		query();
	} else {
		showGetAccessKey();	
	}
}

function showApiTester(access_token) {
	$('#token-form').hide();
	$('#api-tester').show();
	$('#access_token').val(access_token);
	var template = Handlebars.compile($('#tabs-template').html());
	$("#main").append(template(config));
	$('.nav-tabs').find('li:first').addClass('active');
	$('.tab-content').find('form:first').addClass('active');
	attachEventHandlers();
}


function showGetAccessKey() {
	$('#token-form').show();
	$('#api-tester').hide();
}

function checker() {
	$(this).find('input').prop('checked', true);
	reload();
}

function reload() {
	$('.tab-pane.active').find('.display-results').empty();
	$('.tab-pane.active').find('button').trigger('click');
}

function urlize($el){
	var strings = $el.find('.str'),
		txt = "",
		href = "",
		$a = "";
	$.each(strings, function() {
		txt = $(this).html();
		if(txt.indexOf("https://") != -1 || txt.indexOf("http://") != -1) {
			href = txt.replace(/\"/g, "");
			$a = $("<a />").html(href).attr("href", href + "?client_id=" + config.client_id).attr("target", "_blank");
			$(this).empty();
			$(this).append("\"").append($a).append("\"");
		}
	})
}

function photoify($el){
	var strings = $el.find('.str'),
		txt = "",
		href = "",
		src = "",
		$a = "",
		$img;
	$.each(strings, function() {
		txt = $(this).html();
		if(txt.indexOf("://") != -1) {
			if(txt.indexOf(".jpg") != -1) {
				src = txt.replace(/\"/g, "");
				$img = $("<img />").attr("src", src).addClass("thumbnail");
				$(this).html($img);
			} else {
				href = txt.replace(/\"/g, "");
				$a = $("<a />").html(href).attr("href", href + "?client_id=" + config.client_id).attr("target", "_blank");
				$(this).empty();
				$(this).append("\"").append($a).append("\"");	
			}
		}
	})
};

init();