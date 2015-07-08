{{#if next}}
	<a class="btn btn-default next-page" href="#" target="{{next}}">More</a><br>
{{/if}}

{{#results}}
<div class="thumbnail instagram-thumb">
    <img src="{{path_small}}" />
    <div class="caption">
    	<p>{{name}}<br>
    		<span class="badge">{{show_lat_lng geometry}}</span>
    		{{tagify tags}}
    	</p>
    </div>
</div>
{{/results}}

<script>
	var $tab = $('.tab-pane.active'); 
	$tab.find(".next-page").click(function(e) {
		e.preventDefault();
	    $tab.find('input').val($(this).attr("target"));
	  	$tab.find('button').trigger('click');
	});
</script>