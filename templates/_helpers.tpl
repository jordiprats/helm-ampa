{{/*
Expand the name of the chart.
*/}}
{{- define "ampa.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "ampa.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "ampa.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "ampa.labels" -}}
helm.sh/chart: {{ include "ampa.chart" . }}
{{ include "ampa.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "ampa-static.labels" -}}
helm.sh/chart: {{ include "ampa.chart" . }}-static
{{ include "ampa.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "ampa-processing.labels" -}}
helm.sh/chart: {{ include "ampa.chart" . }}-processing
{{ include "ampa-processing.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "ampa.selectorLabels" -}}
app.kubernetes.io/name: {{ include "ampa.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "ampa-static.selectorLabels" -}}
app.kubernetes.io/name: {{ include "ampa.name" . }}-static
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "ampa-processing.selectorLabels" -}}
app.kubernetes.io/name: {{ include "ampa.name" . }}-processing
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}


{{/*
Create the name of the service account to use
*/}}
{{- define "ampa.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "ampa.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
