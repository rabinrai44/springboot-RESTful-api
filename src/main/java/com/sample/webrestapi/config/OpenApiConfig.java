package com.sample.webrestapi.config;

import io.swagger.v3.oas.annotations.OpenAPIDefinition;
import io.swagger.v3.oas.annotations.info.Contact;
import io.swagger.v3.oas.annotations.info.Info;
import io.swagger.v3.oas.annotations.info.License;
import io.swagger.v3.oas.annotations.servers.Server;

@OpenAPIDefinition(info = @Info(contact = @Contact(name = "Rabin Rai", email = "contact@rabinrai.com", url = "https://rabinrai.com/docs"), title = "Sample REST API", description = "OpenApi documentation for sample REST API application.", version = "1.0", license = @License(name = "Apache 2.0", url = "https://www.apache.org/licenses/LICENSE-2.0.html"), termsOfService = "https://rabinrai.com/terms"), servers = {
        @Server(description = "Local ENV", url = "http://localhost:8080"),
        @Server(description = "Production ENV", url = "http://localhost:8080")
})
public class OpenApiConfig {

}
