
Auth provider for minetest

Uses the [mtui](https://github.com/minetest-go/mtui) to delegate user logins


# Source
* https://git.bananach.space/AuthMinetest.git



```php
$wgGroupPermissions['*']['edit'] = false;
$wgGroupPermissions['*']['createaccount'] = false;
$wgGroupPermissions['*']['autocreateaccount'] = true;


wfLoadExtension( 'AuthMinetest' );

$wgAuthManagerAutoConfig['primaryauth'] = [
	MediaWiki\Auth\MinetestPasswordPrimaryAuthenticationProvider::class => [
		'class' => MediaWiki\Auth\MinetestPasswordPrimaryAuthenticationProvider::class,
		'args' => [
			[
				'minetestUrl' => 'http://your-mtui-url',
			]
		],
		'sort' => 0,
	],
];
```
