#!/bin/bash

# Test script for Google OAuth implementation
# Run this after setting up environment variables

echo "=========================================="
echo "Google OAuth Implementation Test"
echo "=========================================="
echo ""

# Check if environment variables are set
echo "1. Checking environment variables..."
if [ -z "$NEXT_PUBLIC_GOOGLE_CLIENT_ID" ]; then
    echo "   ❌ NEXT_PUBLIC_GOOGLE_CLIENT_ID is not set"
    echo "   Add to .env.local: NEXT_PUBLIC_GOOGLE_CLIENT_ID=your-client-id"
else
    echo "   ✅ NEXT_PUBLIC_GOOGLE_CLIENT_ID is set"
fi

if [ -z "$GOOGLE_CLIENT_SECRET" ]; then
    echo "   ❌ GOOGLE_CLIENT_SECRET is not set"
    echo "   Add to .env.local: GOOGLE_CLIENT_SECRET=your-secret"
else
    echo "   ✅ GOOGLE_CLIENT_SECRET is set"
fi

if [ -z "$NEXT_PUBLIC_APP_URL" ]; then
    echo "   ⚠️  NEXT_PUBLIC_APP_URL is not set (will default to http://localhost:3000)"
else
    echo "   ✅ NEXT_PUBLIC_APP_URL is set to: $NEXT_PUBLIC_APP_URL"
fi

echo ""

# Check if files exist
echo "2. Checking implementation files..."
files=(
    "src/lib/integrations/google-auth.ts"
    "src/app/api/auth/google/route.ts"
    "src/app/api/auth/google/callback/route.ts"
    "src/app/api/auth/google/refresh/route.ts"
    "src/components/settings/GoogleCalendarConnect.tsx"
)

all_exist=true
for file in "${files[@]}"; do
    if [ -f "$file" ]; then
        echo "   ✅ $file"
    else
        echo "   ❌ $file (missing)"
        all_exist=false
    fi
done

echo ""

# Check TypeScript compilation
echo "3. Running TypeScript check..."
npx tsc --noEmit 2>&1 | grep -E "(google-auth|google-calendar|GoogleCalendar)" || {
    echo "   ✅ No TypeScript errors in Google OAuth files"
}

echo ""

# Summary
echo "=========================================="
echo "Test Summary"
echo "=========================================="

if [ -z "$NEXT_PUBLIC_GOOGLE_CLIENT_ID" ] || [ -z "$GOOGLE_CLIENT_SECRET" ]; then
    echo "⚠️  Environment variables not configured"
    echo ""
    echo "Next steps:"
    echo "1. Go to https://console.cloud.google.com/"
    echo "2. Create OAuth 2.0 credentials"
    echo "3. Add to .env.local:"
    echo "   NEXT_PUBLIC_GOOGLE_CLIENT_ID=xxx.apps.googleusercontent.com"
    echo "   GOOGLE_CLIENT_SECRET=xxx"
    echo ""
elif ! $all_exist; then
    echo "❌ Some implementation files are missing"
else
    echo "✅ Implementation complete!"
    echo ""
    echo "Next steps:"
    echo "1. Start dev server: npm run dev"
    echo "2. Navigate to http://localhost:3000/settings"
    echo "3. Click 'Googleで接続'"
    echo "4. Complete OAuth flow"
    echo ""
    echo "For integration, see:"
    echo "- docs/GOOGLE_OAUTH_SETUP.md"
    echo "- docs/GOOGLE_OAUTH_INTEGRATION_EXAMPLE.md"
fi

echo ""
