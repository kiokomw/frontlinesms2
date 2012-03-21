package frontlinesms2

import frontlinesms2.camel.clickatell.*

import org.apache.camel.builder.RouteBuilder
import org.apache.camel.model.RouteDefinition

class ClickatellFconnection extends Fconnection {
	private static final String CLICKATELL_URL = 'http://api.clickatell.com/http'
	
	String apiId
	String username
	String password // FIXME maybe encode this rather than storing plaintext
	
	static passwords = ['password']
	
	List<RouteDefinition> getRouteDefinitions() {
		return new RouteBuilder() {
			@Override void configure() {}
			List getRouteDefinitions(Fconnection c) {
				return [from("seda:out-${ClickatellFconnection.this.id}")
						.process(new ClickatellPreProcessor())
						.setHeader(Exchange.HTTP_URI,
								simple(CLICKATELL_URL + '/sendmsg?' + 
										'api_id=${header.clickatell.apiId}&' +
										'user=${header.clickatell.username}&' + 
										'password=${header.clickatell.password}&' + 
										'to=${header.clickatell.dst}&' +
										'text=${body}'))
						.to(CLICKATELL_URL)
						.process(new ClickatellPostProcessor())
						.routeId("out-internet-${ClickatellFconnection.this.id}")]
			}
		}.routeDefinitions
	}
}
