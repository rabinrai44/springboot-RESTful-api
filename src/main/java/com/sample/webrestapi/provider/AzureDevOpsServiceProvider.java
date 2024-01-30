package com.sample.webrestapi.provider;

import java.util.Arrays;
import java.util.Base64;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.core.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.sample.webrestapi.dto.AzureDevOpsResult;
import com.sample.webrestapi.dto.GitRepository;

@Component
public class AzureDevOpsServiceProvider {
  @Value("${azure.devops.organization}")
  private String organization;

  @Value("${azure.devops.project}")
  private String project;

  @Value("${azure.devops.token}")
  private String personalAccessToken;

  @Value("${azure.devops.baseUrl}")
  private String baseUrl;

  @Autowired
  private RestTemplate restTemplate;

  private static final Logger logger = (Logger) LogManager.getLogger(AzureDevOpsServiceProvider.class);

  public List<GitRepository> getRepositories() {
    String url = getApiUrl() + "/git/repositories?api-version=6.0";
    var entity = new HttpEntity<String>(createBasicAuthHeaders());
    ResponseEntity<String> response = restTemplate.exchange(url,
        org.springframework.http.HttpMethod.GET,
        entity, String.class);

    try {
      var result = new ObjectMapper()
          .findAndRegisterModules().readValue(response.getBody(),
              new TypeReference<AzureDevOpsResult<GitRepository>>() {
              });

      return result.getValue() != null ? Arrays.asList(result.getValue()) : null;
    } catch (JsonProcessingException e) {
      logger.error("Error processing response from Azure DevOps REST API", e);
      return null;
    }
  }

  public GitRepository getRepository(String repositoryId) {
    String url = getApiUrl() + "/git/repositories/" + repositoryId + "?api-version=6.0";
    var entity = new HttpEntity<String>(createBasicAuthHeaders());
    // Make the HTTP GET request to the Azure DevOps REST API
    ResponseEntity<String> response = restTemplate.exchange(url,
        org.springframework.http.HttpMethod.GET,
        entity, String.class);

    try {
      var result = new ObjectMapper()
          .findAndRegisterModules().readValue(response.getBody(),
              new TypeReference<GitRepository>() {
              });

      return result;
    } catch (JsonProcessingException e) {
      logger.error("Error processing response from Azure DevOps REST API", e);
      return null;
    }
  }

  private HttpHeaders createBasicAuthHeaders() {
    // Set the headers you need to pass the PAT to the Azure DevOps REST API
    HttpHeaders headers = new HttpHeaders();
    headers.setAccept(Arrays.asList(MediaType.APPLICATION_JSON));
    headers.set("Authorization",
        "Basic " + Base64.getEncoder().encodeToString((":" + personalAccessToken).getBytes()));

    return headers;
  }

  private String getApiUrl() {
    return this.baseUrl + "/" + this.organization + "/" + this.project + "/_apis";
  }
}
