#include "tokenKind.h"

char* token_name(TokenKind kind)
{
  switch (kind) {
#define TOK(X) case TOKEN_ ## X: return #X;
#include "tokenKinds.h"
    default: return NULL;
  }
}
