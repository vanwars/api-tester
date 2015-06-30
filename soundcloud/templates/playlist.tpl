<h2>{{ description}}</h2>
<div class="row" style="padding:10px;">
{{#tracks}}
	<div class="thumbnail track-thumb">
	{{#if artwork_url }}
		<img class="thumbnail" src="{{ artwork_url }}" />
	{{else}}
		<img class="thumbnail" src="{{ user.avatar_url }}" />
	{{/if}}
	{{#if stream_url}}
		<audio controls>
		  	<source src="{{ append_client_id_to_url stream_url }}" type="audio/mpeg">
			Your browser does not support the audio element.
		</audio>
		<p>
			<b>{{title}}</b> 
			{{ description }}
		</p>
	{{/if}}
	</div>
{{/tracks}}
</div>