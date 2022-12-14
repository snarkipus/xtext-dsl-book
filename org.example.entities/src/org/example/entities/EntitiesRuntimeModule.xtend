/*
 * generated by Xtext 2.27.0
 */
package org.example.entities

import org.example.entities.generator.EntitiesOutputConfigurationProvider
import org.eclipse.xtext.generator.IOutputConfigurationProvider

/**
 * Use this class to register components to be used at runtime / without the Equinox extension registry.
 */
class EntitiesRuntimeModule extends AbstractEntitiesRuntimeModule {
	def Class<? extends IOutputConfigurationProvider> bindIOutputConfigurationProvider() {
		return EntitiesOutputConfigurationProvider
	}
}
