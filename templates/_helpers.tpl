{{/*
Common template helpers for kolosal-retrieval-management-system
These mirror standard Helm starter helpers plus component specific service name helpers used across templates.
*/}}

{{/* Expand the chart name (truncated at 63 chars) */}}
{{- define "kolosal-platform.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* Chart fullname helper (release-name + chart name) */}}
{{- define "kolosal-platform.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := include "kolosal-platform.name" . -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/* Standard labels */}}
{{- define "kolosal-platform.labels" -}}
app.kubernetes.io/name: {{ include "kolosal-platform.name" . }}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
{{- end -}}

{{/* Selector labels (stable subset) */}}
{{- define "kolosal-platform.selectorLabels" -}}
app.kubernetes.io/name: {{ include "kolosal-platform.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/* Generic helper to build a component service name: <fullname>-<component> */}}
{{- define "kolosal-platform.componentServiceName" -}}
{{- $root := index . 0 -}}
{{- $component := index . 1 -}}
{{- printf "%s-%s" (include "kolosal-platform.fullname" $root) $component | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* Component specific service names used in templates */}}
{{- define "kolosal-platform.qdrant.serviceName" -}}
{{- printf "%s" (include "kolosal-platform.componentServiceName" (list . "qdrant")) -}}
{{- end -}}

{{- define "kolosal-platform.dashboard.serviceName" -}}
{{- printf "%s" (include "kolosal-platform.componentServiceName" (list . "dashboard")) -}}
{{- end -}}

{{- define "kolosal-platform.docling.serviceName" -}}
{{- printf "%s" (include "kolosal-platform.componentServiceName" (list . "docling")) -}}
{{- end -}}

{{- define "kolosal-platform.markitdown.serviceName" -}}
{{- printf "%s" (include "kolosal-platform.componentServiceName" (list . "markitdown")) -}}
{{- end -}}

{{- define "kolosal-platform.kolosalServer.serviceName" -}}
{{- printf "%s" (include "kolosal-platform.componentServiceName" (list . "kolosal-server")) -}}
{{- end -}}

{{/* API keys secret name helper */}}
{{- define "kolosal-platform.apiKeysSecretName" -}}
{{- /* Defensive: .Values.apiKeysSecret may be nil or not a map */ -}}
{{- $api := (index .Values "apiKeysSecret") | default dict -}}
{{- $name := (index $api "name") | default "" -}}
{{- if $name -}}
{{- $name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-api-keys" (include "kolosal-platform.fullname" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/* Optional storageClass override (cluster default if empty) */}}
{{- define "kolosal-platform.storageClass" -}}
{{- /* .Values.global may be nil */ -}}
{{- $global := (index .Values "global") | default dict -}}
{{- (index $global "storageClass") | default "" -}}
{{- end -}}

{{/* ConfigMap name for kolosal server configuration */}}
{{- define "kolosal-platform.kolosalConfigName" -}}
{{- $kolosalServer := (index .Values "kolosalServer") | default dict -}}
{{- $cfg := (index $kolosalServer "config") | default dict -}}
{{- $cfgName := (index $cfg "name") | default "" -}}
{{- if $cfgName -}}
{{- $cfgName | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-config" (include "kolosal-platform.fullname" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
