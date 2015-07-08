<h2>Snippets</h2>
<ul>
{{#results}}
	<li>
		<strong>{{ description }}</strong>
		<br>
		<a href="{{example_url}}" target="_blank">View Example</a>
		<br>
		{{tagify tags}}
	</li>
{{/results}}
</ul>