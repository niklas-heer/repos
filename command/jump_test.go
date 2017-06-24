package command

import (
	"testing"

	"github.com/mitchellh/cli"
)

func TestJumpCommand_implement(t *testing.T) {
	var _ cli.Command = &JumpCommand{}
}
