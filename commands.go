package main

import (
	"github.com/mitchellh/cli"
	"github.com/niklas-heer/repos/command"
)

func Commands(meta *command.Meta) map[string]cli.CommandFactory {
	return map[string]cli.CommandFactory{
		"jump": func() (cli.Command, error) {
			return &command.JumpCommand{
				Meta: *meta,
			}, nil
		},
		"list": func() (cli.Command, error) {
			return &command.ListCommand{
				Meta: *meta,
			}, nil
		},
		"status": func() (cli.Command, error) {
			return &command.StatusCommand{
				Meta: *meta,
			}, nil
		},
		"add": func() (cli.Command, error) {
			return &command.AddCommand{
				Meta: *meta,
			}, nil
		},
		
		"version": func() (cli.Command, error) {
			return &command.VersionCommand{
				Meta:     *meta,
				Version:  Version,
				Revision: GitCommit,
				Name: Name,
			}, nil
		},
	}
}
