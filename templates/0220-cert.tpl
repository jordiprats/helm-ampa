{{- if .Values.ingress.enabled -}}
{{- if .Values.ingress.tls -}}
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: {{ include "ampa.fullname" . }}-le-crt
spec:
  secretName: tls-secret
  issuerRef:
    kind: Issuer
    name: letsencrypt
  commonName: {{ .Values.ingress.hosts.app }}
  dnsNames:
  - {{ .Values.ingress.hosts.app }}
  - {{ .Values.ingress.hosts.static }}
{{- end }}
{{- end }}