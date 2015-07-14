<div class="pager-container">
	{{#if previous}}
		<a class="btn btn-default paging" href="#" target="{{previous}}">Previous</a>
	{{/if}}
	{{#if next}}
		<a class="btn btn-default paging" href="#" target="{{next}}">Next</a>
	{{/if}}
</div>
<br>
{{#results}}
<div class="thumbnail instagram-thumb">
    <img src="{{path_small}}" />
    <div class="caption">
    	<p>
    		{{name}}<br>
	    	{{#if geometry}}
	    		<span class="badge">{{show_lat_lng geometry}}</span>
	    	{{/if}}
    		{{tagify tags}}
    	</p>
    </div>
</div>
{{/results}}

<script>
	var $tab = $('.tab-pane.active'); 
	$tab.find(".paging").click(function(e) {
		e.preventDefault();
	    $tab.find('input').val($(this).attr("target"));
	  	$tab.find('button').trigger('click');
	});
</script>