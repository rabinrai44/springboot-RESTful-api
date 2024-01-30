package com.sample.webrestapi.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.sample.webrestapi.provider.AzureDevOpsServiceProvider;

@RestController
@RequestMapping("/api/v1/application")
public class ApplicationController {

  @Autowired
  private AzureDevOpsServiceProvider azureServiceProvider;

  @GetMapping("repositories")
  public ResponseEntity<?> getRepositories() {
    var repositories = azureServiceProvider.getRepositories();
    return ResponseEntity.ok().body(repositories);
  }

  @GetMapping("repositories/{repositoryId}")
  public ResponseEntity<?> getRepository(@PathVariable String repositoryId) {
    var repository = azureServiceProvider.getRepository(repositoryId);
    if (repository == null) {
      return ResponseEntity.notFound().build();
    }
    return ResponseEntity.ok().body(repository);
  }
}
