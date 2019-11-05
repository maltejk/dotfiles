#!/bin/bash

_kube_ps1_get_cluster() {
  $KUBE_PS1_BINARY config view --minify --output 'jsonpath={.clusters[0].name}'
}

# Build our prompt
kube_ps1() {
  [[ "${KUBE_PS1_ENABLED}" == "off" ]] && return
  [[ -z "${KUBE_PS1_CONTEXT}" ]] && return

  local KUBE_PS1
  local KUBE_PS1_RESET_COLOR="${_KUBE_PS1_OPEN_ESC}${_KUBE_PS1_DEFAULT_FG}${_KUBE_PS1_CLOSE_ESC}"

  # Background Color
  [[ -n "${KUBE_PS1_BG_COLOR}" ]] && KUBE_PS1+="$(_kube_ps1_color_bg ${KUBE_PS1_BG_COLOR})"

  # Prefix
  [[ -n "${KUBE_PS1_PREFIX}" ]] && KUBE_PS1+="${KUBE_PS1_PREFIX}"

  # Cluster name
  KUBE_PS1+="$(_kube_ps1_get_cluster)"
  
  if [[ -n "${KUBE_PS1_SEPARATOR}" ]]; then
    KUBE_PS1+="${KUBE_PS1_SEPARATOR}"
  fi

  # Symbol
  KUBE_PS1+="$(_kube_ps1_color_fg $KUBE_PS1_SYMBOL_COLOR)$(_kube_ps1_symbol)${KUBE_PS1_RESET_COLOR}"

  if [[ -n "${KUBE_PS1_SEPARATOR}" ]] && [[ "${KUBE_PS1_SYMBOL_ENABLE}" == true ]]; then
    KUBE_PS1+="${KUBE_PS1_SEPARATOR}"
  fi

  # Context
  KUBE_PS1+="$(_kube_ps1_color_fg $KUBE_PS1_CTX_COLOR)${KUBE_PS1_CONTEXT}${KUBE_PS1_RESET_COLOR}"

  # Namespace
  if [[ "${KUBE_PS1_NS_ENABLE}" == true ]]; then
    if [[ -n "${KUBE_PS1_DIVIDER}" ]]; then
      KUBE_PS1+="${KUBE_PS1_DIVIDER}"
    fi
    KUBE_PS1+="$(_kube_ps1_color_fg ${KUBE_PS1_NS_COLOR})${KUBE_PS1_NAMESPACE}${KUBE_PS1_RESET_COLOR}"
  fi

  # Suffix
  [[ -n "${KUBE_PS1_SUFFIX}" ]] && KUBE_PS1+="${KUBE_PS1_SUFFIX}"

  # Close Background color if defined
  [[ -n "${KUBE_PS1_BG_COLOR}" ]] && KUBE_PS1+="${_KUBE_PS1_OPEN_ESC}${_KUBE_PS1_DEFAULT_BG}${_KUBE_PS1_CLOSE_ESC}"

  echo "${KUBE_PS1}"
}
