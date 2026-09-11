package main

import (
	"context"
	"testing"

	"github.com/hbjydev/containers/testhelpers"
)

func Test(t *testing.T) {
	image := testhelpers.GetTestImage("git.hayden.moe/hayden/containers/openclaw:rolling")

	testhelpers.TestCommandSucceeds(t, context.Background(), image, nil, "openclaw", "--version")

	// The point of this image is to install extra tools for myself on the image
	// used to run OpenClaw, so this test just checks that those tools are
	// available.
	testhelpers.TestCommandSucceeds(t, context.Background(), image, nil, "kubectl", "version", "--client", "--output=yaml")
	testhelpers.TestCommandSucceeds(t, context.Background(), image, nil, "mise", "--version")
	testhelpers.TestCommandSucceeds(t, context.Background(), image, nil, "mise", "x", "aqua:casey/just", "--", "just", "--version")
}
