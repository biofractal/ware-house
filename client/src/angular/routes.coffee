angular
.module 'ware-house-client'
.config ($stateProvider) ->

	$stateProvider

		.state 'app',
			url:'/'
			templateUrl: "app.html"
			data: requireLogin: true

		.state 'app.authenticate',
			url:'authenticate'
			templateUrl: "authenticate.html"
			data: requireLogin: false
			controller: 'authenticate'

		.state 'app.verify',
			url:'verify/:vid'
			templateUrl: "verify.html"
			data: requireLogin: false
			controller: 'verify'

		.state 'app.products',
			url:'products'
			templateUrl: "products.html"
			resolve:
				products:(proxy)-> proxy.product.getAll()
			controller: 'products'

		.state 'app.product',
			url:'product/:id'
			templateUrl: "product.html"
			resolve:
				product:($stateParams, proxy)-> proxy.product.getById $stateParams.id
			controller: 'product'

		.state 'app.houses',
			url:'houses'
			templateUrl: "houses.html"
			resolve:
				houses:(proxy)-> proxy.house.getAll()
			controller: 'house'

		.state 'app.house',
			url:'house/:id'
			templateUrl: "house.html"
			resolve:
				house:($stateParams, proxy)-> proxy.house.getById $stateParams.id
			controller: 'house'