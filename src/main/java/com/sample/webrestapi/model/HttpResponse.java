package com.sample.webrestapi.model;

import java.util.Map;

import org.springframework.http.HttpStatus;

import com.fasterxml.jackson.annotation.JsonInclude;

@JsonInclude(JsonInclude.Include.NON_DEFAULT)
public class HttpResponse {
    protected String timeStamp;
    protected int statusCode;
    protected HttpStatus status;
    protected String reason;
    protected String message;
    protected String developerMessage;
    protected Map<?, ?> data;

    public String getTimeStamp() {
        return timeStamp;
    }

    public int getStatusCode() {
        return statusCode;
    }

    public HttpStatus getStatus() {
        return status;
    }

    public String getReason() {
        return reason;
    }

    public String getMessage() {
        return message;
    }

    public String getDeveloperMessage() {
        return developerMessage;
    }

    public Map<?, ?> getData() {
        return data;
    }

    public static Builder builder() {
        return new Builder();
    }

    public static class Builder {
        private HttpResponse response = new HttpResponse();

        public Builder timeStamp(String timeStamp) {
            response.timeStamp = timeStamp;
            return this;
        }

        public Builder statusCode(int statusCode) {
            response.statusCode = statusCode;
            return this;
        }

        public Builder status(HttpStatus status) {
            response.status = status;
            return this;
        }

        public Builder reason(String reason) {
            response.reason = reason;
            return this;
        }

        public Builder message(String message) {
            response.message = message;
            return this;
        }

        public Builder developerMessage(String developerMessage) {
            response.developerMessage = developerMessage;
            return this;
        }

        public Builder data(Map<?, ?> data) {
            response.data = data;
            return this;
        }

        public HttpResponse build() {
            return response;
        }
    }

}
