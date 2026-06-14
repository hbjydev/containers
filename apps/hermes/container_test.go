package main

import (
	"context"
	"testing"

	"github.com/hbjydev/containers/testhelpers"
)

func Test(t *testing.T) {
	image := testhelpers.GetTestImage("forgejo.hayden.moe/hayden/containers/hermes:rolling")

	// The point of this image is to install extra tools for myself on the image
	// used to run Hermes, so this test just checks that those tools are
	// available.
	testhelpers.TestCommandSucceeds(t, context.Background(), image, nil, "gws", "--version")
	testhelpers.TestCommandSucceeds(t, context.Background(), image, nil, "ob", "--version")
	testhelpers.TestCommandSucceeds(t, context.Background(), image, nil, "kubectl", "version", "--client", "--output=yaml")
}
