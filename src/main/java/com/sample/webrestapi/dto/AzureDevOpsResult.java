package com.sample.webrestapi.dto;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown = true)
public class AzureDevOpsResult<T> {
  private int count;
  private T[] value;

  public AzureDevOpsResult() {
  }

  public int getCount() {
    return count;
  }

  public void setCount(int count) {
    this.count = count;
  }

  public T[] getValue() {
    return value;
  }

  public void setValue(T[] value) {
    this.value = value;
  }
}
