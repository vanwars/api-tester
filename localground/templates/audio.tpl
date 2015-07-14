{{#if next}}
	<a class="btn btn-default next-page" href="#" target="{{next}}">More</a><br>
{{/if}}

{{#results}}
<div class="thumbnail track">
	<audio controls>
	  	<source src="{{ file_path }}" type="audio/mpeg">
		Your browser does not support the audio element.
	</audio>
	{{ name }}
	{{#if geometry}}
		<span class="badge">{{show_lat_lng geometry}}</span>
	{{/if}}
	{{tagify tags}}
</div>
{{/results}}