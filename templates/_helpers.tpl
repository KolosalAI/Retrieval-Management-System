{{/*
Helper template definitions for kolosal-platform.* references used across manifests.
These ensure helm lint/render finds required named templates.
*/}}

{{- define "kolosal-platform.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

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

{{- define "kolosal-platform.selectorLabels" -}}
app.kubernetes.io/name: {{ include "kolosal-platform.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{- define "kolosal-platform.labels" -}}
helm.sh/chart: {{ printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" }}
{{ include "kolosal-platform.selectorLabels" . }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{- define "kolosal-platform.apiKeysSecretName" -}}
{{ include "kolosal-platform.fullname" . }}-api-keys
{{- end -}}

{{- define "kolosal-platform.qdrant.serviceName" -}}
{{ include "kolosal-platform.fullname" . }}-qdrant
{{- end -}}

{{- define "kolosal-platform.storageClass" -}}
{{- default "" .Values.global.storageClass -}}
{{- end -}}

{{- define "kolosal-platform.kolosalConfigName" -}}
{{ include "kolosal-platform.fullname" . }}-config
{{- end -}}
