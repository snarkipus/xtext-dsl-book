/*
 * generated by Xtext 2.27.0
 */
package org.example.entities.tests

import com.google.inject.Guice
import com.google.inject.Injector
import org.eclipse.xtext.testing.GlobalRegistries
import org.eclipse.xtext.testing.GlobalRegistries.GlobalStateMemento
import org.eclipse.xtext.testing.IInjectorProvider
import org.eclipse.xtext.testing.IRegistryConfigurator
import org.example.entities.EntitiesRuntimeModule
import org.example.entities.EntitiesStandaloneSetup

class EntitiesInjectorProvider implements IInjectorProvider, IRegistryConfigurator {
	protected GlobalStateMemento stateBeforeInjectorCreation
	protected GlobalStateMemento stateAfterInjectorCreation
	protected Injector injector
//	static final Void static_initializer = {
//		{
//			GlobalRegistries.initializeDefaults()
//		}
//		null
//	}

	override Injector getInjector() {
		if (injector === null) {
			this.injector = internalCreateInjector()
			stateAfterInjectorCreation = GlobalRegistries.makeCopyOfGlobalState()
		}
		return injector
	}

	def protected Injector internalCreateInjector() {
		return new EntitiesStandaloneSetup() {
			override Injector createInjector() {
				return Guice.createInjector(createRuntimeModule())
			}
		}.createInjectorAndDoEMFRegistration()
	}

	def protected EntitiesRuntimeModule createRuntimeModule() {
		// make it work also with Maven/Tycho and OSGI
		// see https://bugs.eclipse.org/bugs/show_bug.cgi?id=493672
		return new EntitiesRuntimeModule() {
			override ClassLoader bindClassLoaderToInstance() {
				return EntitiesInjectorProvider.getClassLoader()
			}
		}
	}

	override void restoreRegistry() {
		stateBeforeInjectorCreation.restoreGlobalState()
		stateBeforeInjectorCreation = null
	}

	override void setupRegistry() {
		stateBeforeInjectorCreation = GlobalRegistries.makeCopyOfGlobalState()
		if (injector === null) {
			getInjector()
		}
		stateAfterInjectorCreation.restoreGlobalState()
	}
}
