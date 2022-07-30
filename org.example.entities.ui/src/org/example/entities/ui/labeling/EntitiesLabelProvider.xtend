/*
 * generated by Xtext 2.27.0
 */
package org.example.entities.ui.labeling

import com.google.inject.Inject
import org.eclipse.emf.edit.ui.provider.AdapterFactoryLabelProvider
import org.eclipse.xtext.ui.label.DefaultEObjectLabelProvider
import org.example.entities.entities.Attribute
import org.example.entities.entities.Entity
/**
 * Provides labels for EObjects.
 * 
 * See https://www.eclipse.org/Xtext/documentation/310_eclipse_support.html#label-provider
 */
class EntitiesLabelProvider extends DefaultEObjectLabelProvider {

	@Inject extension TypeRepresentation

	@Inject
	new(AdapterFactoryLabelProvider delegate) {
		super(delegate);
	}

	def text(Attribute a) {
		a.name + if (a.type !== null)
			" : " + a.type.representation
		else
			""
	}

	def image(Entity e) { "Entity.gif" }

	def image(Attribute a) { "Attribute.gif" }
}
