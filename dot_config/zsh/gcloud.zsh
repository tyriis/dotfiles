if [[ -f /usr/bin/gcloud ]]; then
  source /opt/google-cloud-sdk/completion.zsh.inc
  source /opt/google-cloud-sdk/path.zsh.inc
  export CLOUDSDK_PYTHON=/usr/bin/python3
  export USE_GKE_GCLOUD_AUTH_PLUGIN=True
fi
